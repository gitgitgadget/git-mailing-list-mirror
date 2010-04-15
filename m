From: Christian Couder <chriscool@tuxfamily.org>
Subject: GSoC 2010: "Integrated Web Client for git" proposal
Date: Thu, 15 Apr 2010 05:30:44 +0100
Message-ID: <201004150630.44300.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Sam Vilain <sam@vilain.net>, catalyst@lists.scsys.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 06:31:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Gjd-0006X3-3K
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 06:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab0DOEbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 00:31:14 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:48640 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471Ab0DOEbF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 00:31:05 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 663B4818070;
	Thu, 15 Apr 2010 06:30:52 +0200 (CEST)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5DD53818062;
	Thu, 15 Apr 2010 06:30:49 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144947>

Hi!

Pavan Kumar Sunkara sent an email on the git mailing list a few days ago about 
his GSoC proposal:

http://thread.gmane.org/gmane.comp.version-control.git/144658/

His proposal is based on the project he already started:

http://github.com/pkumar/gittor

There have been discussions about it on the GSoC web app and in some private 
emails.

Possible GSoC mentors for this proposal don't want yet another web interface, 
they want an existing interface to be improved on. As the obvious choice is to 
improve gitweb, the current result from the discussions is that the proposal 
should be changed so that the integrated web client is developed in Perl into 
or alongside gitweb.

Pavan agreed to rewrite his proposal according to that and Petr and myself 
volunteered to co-mentor him.

It was suggested that improving Gitalist 
(http://wiki.catalystframework.org/wiki/gitalist) would be a better choice. 
But this was rejected because Gitalist is too much different from gitweb so it 
could not replace it for many people now using gitweb.

Best regards,
Christian.


 
