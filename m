From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Enhancement Request: "locale" git option
Date: Thu, 04 Dec 2014 08:32:57 +0100
Message-ID: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 08:33:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwQuQ-0005Ev-6F
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 08:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbaLDHdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 02:33:01 -0500
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:53584 "EHLO
	rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbaLDHdA convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-git@vger.kernel.org:1:1>);
	Thu, 4 Dec 2014 02:33:00 -0500
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 7F38B43229
	for <git@vger.kernel.org>; Thu,  4 Dec 2014 08:32:58 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 686AF36B4E
	for <git@vger.kernel.org>; Thu,  4 Dec 2014 08:32:58 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
	with Novell_GroupWise; Thu, 04 Dec 2014 08:32:58 +0100
X-Mailer: Novell GroupWise Internet Agent 14.0.1 
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260729>

Hi!

I'm native German, but German git messages confuse me (yopu'll have to correlate them with the man pages). At the moment git uses the locale settings from the environment, so you can only change git's locale settings by changing the environment (like "LANG= git ...").
OTOH Git has a flexible hierachical option setting mechanism. Why not allow a Git language (locale) setting system-wde, user-wide, or repository-specific.

Regards,
Ulrich
