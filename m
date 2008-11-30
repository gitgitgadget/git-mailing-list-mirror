From: "Felix Andersen" <felix@nibbo.se>
Subject: Managing websites with git
Date: Sun, 30 Nov 2008 17:30:30 +0100
Message-ID: <fe5a74300811300830x850d81csc5cf1f9b367bac11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 17:31:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6pD2-0006lD-PG
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 17:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbYK3Qac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 11:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbYK3Qac
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 11:30:32 -0500
Received: from mail-gx0-f11.google.com ([209.85.217.11]:49800 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbYK3Qac (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 11:30:32 -0500
Received: by gxk4 with SMTP id 4so1818419gxk.13
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 08:30:30 -0800 (PST)
Received: by 10.150.95.15 with SMTP id s15mr19947760ybb.162.1228062630620;
        Sun, 30 Nov 2008 08:30:30 -0800 (PST)
Received: by 10.151.73.5 with HTTP; Sun, 30 Nov 2008 08:30:30 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101977>

Hi!

Is it a bad idea to manage websites (php/xhtml/css) by having a origin
non-bare repo in the hosted dir with the hook mentioned here:
http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73.
I was thinking about any security issues with the .git dir being
hosted. Or is that even the right way to do it?

Thank you
Felix Andersen
