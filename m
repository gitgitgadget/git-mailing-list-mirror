From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Q: "git diff" using tag names
Date: Fri, 28 Oct 2011 14:28:36 +0200
Message-ID: <4EAABC15020000A100007D9D@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:39:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJliU-0008RC-LV
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828Ab1J1MjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:39:03 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:52921 "EHLO
	rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932687Ab1J1MjA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 08:39:00 -0400
X-Greylist: delayed 615 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Oct 2011 08:39:00 EDT
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id F07523983
	for <git@vger.kernel.org>; Fri, 28 Oct 2011 14:28:42 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id DE9E63980
	for <git@vger.kernel.org>; Fri, 28 Oct 2011 14:28:42 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
	with Novell_GroupWise; Fri, 28 Oct 2011 14:28:42 +0200
X-Mailer: Novell GroupWise Internet Agent 2012.0.0 Beta 
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184403>

Hi,

when using a somewhat older git (of SLES11 SP1 SDK), I could not find a way to "git diff" between two tag names; I can only diff between two commit numbers. I can display a changeset using "git show", but that's not what I wanted.
Is it possible to get the diff I want using older versions, and is such a feature implemented in the current version? If so, since when?

As I'm not subscribed to the list, I'd appreciate CC'ed replies. Thank you.

Greeting
Ulrich
