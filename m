From: D Sundstrom <sunds@peapod.net>
Subject: Simple commit mechanism for non-technical users
Date: Tue, 18 Aug 2009 11:05:32 -0500
Message-ID: <ef72456d0908180905u18593b63tdc850b8552db30b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 18:05:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRBv-0007og-Lh
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbZHRQFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbZHRQFc
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:05:32 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:32132 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbZHRQFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:05:31 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1259309qwh.37
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 09:05:32 -0700 (PDT)
Received: by 10.229.53.137 with SMTP id m9mr2541634qcg.36.1250611532991; Tue, 
	18 Aug 2009 09:05:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126405>

I use git to manage all project artifacts, including documentation,
proposals, presentations, and so on.

However, I have a hard time convincing non-technical staff to learn
enough about git or to take the time to go through the effort of
committing changes to a repository.  So the steady stream of email
attachments with "Acme Specification v3" or "final final spemco
proprosal" continues.

I'd hoped there was a simple web interface that would allow a user to
upload and commit a file to a repository, but I've had no luck finding
one.  (I've used cgit for browsing, but it is read-only).

Is anyone aware of a simple way I can have my non-technical users
manage their documents against a git repository?  Ideally this would
involve no installation of software on their machine (unless it were
compelling, for example, the Finder plugin for SVN on the mac was a
great tool for these users; or at least those on a mac...)

-David
