From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] gitk: Update and fix Makefile (spelling fix)
Date: Sun, 13 Jan 2008 22:06:51 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200801132206.52023.stimming@tuhh.de>
References: <200801082154.21282.stimming@tuhh.de> <7vfxx43f5r.fsf@gitster.siamese.dyndns.org> <18311.64910.643392.816623@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 22:10:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEA5g-0001Ev-It
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 22:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829AbYAMVJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 16:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbYAMVJc
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 16:09:32 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:40938 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbYAMVJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 16:09:32 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m0DL96MV000577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 13 Jan 2008 22:09:06 +0100
Received: from [192.168.2.102] (p549035E2.dip0.t-ipconnect.de [84.144.53.226])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m0DL955w005842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 Jan 2008 22:09:06 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <18311.64910.643392.816623@cargo.ozlabs.ibm.com>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70413>

Am Samstag, 12. Januar 2008 00:36 schrieb Paul Mackerras:
> > Christian Stimming (2):
> >       gitk: Fix typo in user message.
>
> I was going to ignore this one since "descendent" is actually a valid
> alternate spelling, and is the one I am used to.  However, I don't
> have a strong feeling about it.

In the dictionaries I consulted before proposing this patch, "descendant" was 
the *only* valid spelling. I checked http://dict.leo.org/?search=descendent , 
(on paper) Oxford Advanced Learner's Dictionary (1998 edition). Now when 
looking up http://www.m-w.com/dictionary/descendent your original spelling is 
also mentioned as a variant, but as the other dictionaries didn't have it, I 
assumed this should rather be changed.

Christian
