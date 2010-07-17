From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCH/RFC 4/4] Add interactive mode to git-shell for 
	user-friendliness
Date: Sat, 17 Jul 2010 10:53:08 -0400
Message-ID: <AANLkTik7VJlCIZHGVLX-eVRTrf45RDUggQqq-FjUtqq9@mail.gmail.com>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu>
	<4C3DC2BD.6020907@digium.com>
	<20100714152444.GA26674@pcpool00.mathematik.uni-freiburg.de>
	<201007141740.37867.trast@student.ethz.ch>
	<20100714160730.GA27078@pcpool00.mathematik.uni-freiburg.de>
	<AANLkTikEjMeKPkyY4RdRq-ESkmmq4PvqCFPgp8yvLVBz@mail.gmail.com>
	<AANLkTikiOgV1iE7dwPUkLpWTb_zXSFdEuOYvyqJ1eDCo@mail.gmail.com>
	<20100717055257.GB29290@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Bernhard R. Link" <brlink@debian.org>,
	Thomas Rast <trast@student.ethz.ch>,
	"Kevin P. Fleming" <kpfleming@digium.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 17 16:53:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oa8le-0005Si-DY
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 16:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab0GQOxO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jul 2010 10:53:14 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:57192 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755212Ab0GQOxN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 10:53:13 -0400
X-AuditID: 12074424-b7b63ae000000a0b-d8-4c41c3d7cef0
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Brightmail Gateway) with SMTP id 74.48.02571.7D3C14C4; Sat, 17 Jul 2010 10:53:12 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o6HErAoT002962
	for <git@vger.kernel.org>; Sat, 17 Jul 2010 10:53:11 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6HEr9V4022372
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sat, 17 Jul 2010 10:53:10 -0400 (EDT)
Received: by iwn7 with SMTP id 7so3099573iwn.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 07:53:09 -0700 (PDT)
Received: by 10.231.146.196 with SMTP id i4mr2197646ibv.110.1279378389127; 
	Sat, 17 Jul 2010 07:53:09 -0700 (PDT)
Received: by 10.231.160.195 with HTTP; Sat, 17 Jul 2010 07:53:08 -0700 (PDT)
In-Reply-To: <20100717055257.GB29290@burratino>
X-Brightmail-Tracker: AAAAAxUrKT8VKysPFSwSbA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151183>

> But first a more basic question: why not just add =93./=94 to the sta=
rt of
> the command name?
Wow, of course... that's the obvious solution.

Thanks for the comments!
