From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] gitk: Update German translation
Date: Sat, 3 May 2008 10:03:09 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200805031003.09458.stimming@tuhh.de>
References: <200805012142.10151.stimming@tuhh.de> <200805022033.01407.stimming@tuhh.de> <18460.6645.918108.615194@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat May 03 11:21:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsDw4-0001F8-1Z
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 11:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758383AbYECJUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 05:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758465AbYECJUw
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 05:20:52 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:49094 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758332AbYECJUv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 05:20:51 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m439Kk8c010675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 3 May 2008 11:20:47 +0200
Received: from [192.168.2.102] (p54901ED6.dip0.t-ipconnect.de [84.144.30.214])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m439KjU3032638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 May 2008 11:20:46 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <18460.6645.918108.615194@cargo.ozlabs.ibm.com>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81064>

Am Samstag, 3. Mai 2008 09:53 schrieb Paul Mackerras:
> Christian Stimming writes:
> > > Well, the commits aren't in date order, strictly speaking, and the
> > > last commit isn't necessarily the oldest (though the first commit will
> > > in fact be the newest).  How about:
> > >
> > > <Home>	Move to head of list
> > > <End>	Move to tail of list
> > >
> > > Would that be any clearer?
> >
> > I think "head of list" and "tail of list" are more the terms about the
> > implementation detail and not so much an explanation that is easily
> > understood for the user. I think some combination using the word "top"
> > should rather be used to make it really clear we're talking about the
> > upper end of the window.
>
> The list isn't just a detail, it's what the user sees in the top pane:
> the commits, listed in some order.
>
> How about "top of list" and "bottom of list"?  Or "start of list" and
> "end of list"?

I think "top of list" and "bottom of list" would work quite well.

Regards,

Christian
