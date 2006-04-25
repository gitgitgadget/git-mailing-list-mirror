From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: [PATCH] Make die() and error() prefix line with binary name if set
Date: Tue, 25 Apr 2006 16:13:58 +0200
Organization: Berlin University of Technology
Message-ID: <20060425141358.GH5482@bolero.cs.tu-berlin.de>
References: <20060425101207.GC5482@bolero.cs.tu-berlin.de> <e2kt7h$o4a$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-From: git-owner@vger.kernel.org Tue Apr 25 16:14:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYOIp-0006eR-Na
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 16:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWDYOOD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 10:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWDYOOC
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 10:14:02 -0400
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:20376 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S932215AbWDYOOA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 10:14:00 -0400
Received: from mailhost.cs.tu-berlin.de (postfix@mail.cs.tu-berlin.de [130.149.17.13])
	by mail.cs.tu-berlin.de (8.9.3p2/8.9.3) with ESMTP id QAA02979
	for <git@vger.kernel.org>; Tue, 25 Apr 2006 16:13:59 +0200 (MEST)
Received: from localhost (localhost [127.0.0.1])
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTP id 35E6FF259
	for <git@vger.kernel.org>; Tue, 25 Apr 2006 16:13:59 +0200 (MEST)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
 by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 10224)
 with ESMTP id 00432-43 for <git@vger.kernel.org>;
 Tue, 25 Apr 2006 16:13:58 +0200 (MEST) 15020
Received: from bolero.cs.tu-berlin.de (bolero.cs.tu-berlin.de [130.149.19.1])
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Tue, 25 Apr 2006 16:13:58 +0200 (MEST)
Received: (from pdmef@localhost)
	by bolero.cs.tu-berlin.de (8.13.6+Sun/8.12.8/Submit) id k3PEDwJW011735
	for git@vger.kernel.org; Tue, 25 Apr 2006 16:13:58 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e2kt7h$o4a$1@sea.gmane.org>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-System: bolero.cs.tu-berlin.de (SunOS 5.9 sun4u)
User-Agent: mutt-ng/devel-r802 (SunOS)
X-Virus-Scanned: by amavisd-new at cs.tu-berlin.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19147>

* Jakub Narebski <jnareb@gmail.com>:

>Wouldn't it be easier (and less idiomatic) to just do

Oh, thanks for pointing it out. The second one I sent fixes it (and is 
against an updated master branch).

   bye, Rocco
-- 
:wq!
