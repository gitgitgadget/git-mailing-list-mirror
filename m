From: Stephen Bash <bash@genarts.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 4 Dec 2012 09:40:31 -0500 (EST)
Message-ID: <1285092455.205649.1354632031815.JavaMail.root@genarts.com>
References: <CAMP44s0rcy6OfMPM+8BhQy0DbxRLBHEsraHw0u4oAZzh5euTzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: esr@thyrsus.com, Magnus =?utf-8?B?QsOkY2s=?= <baeck@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Philippe Vaucher <philippe.vaucher@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 15:40:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tftg7-0006P8-0v
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 15:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567Ab2LDOkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2012 09:40:39 -0500
Received: from hq.genarts.com ([173.9.65.1]:33253 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753045Ab2LDOki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2012 09:40:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 70A4CBE124E;
	Tue,  4 Dec 2012 09:40:37 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EwHNLwLgyZnZ; Tue,  4 Dec 2012 09:40:31 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id D5F91BE13CD;
	Tue,  4 Dec 2012 09:40:31 -0500 (EST)
In-Reply-To: <CAMP44s0rcy6OfMPM+8BhQy0DbxRLBHEsraHw0u4oAZzh5euTzg@mail.gmail.com>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC23 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211085>

----- Original Message -----
> From: "Felipe Contreras" <felipe.contreras@gmail.com>
> Sent: Tuesday, December 4, 2012 9:19:18 AM
> Subject: Re: Python extension commands in git - request for policy change
> 
> > > Also, you are ignoring all the advantages that shell has and
> > > python does not.
> >
> > Out of curiosity, can you list the advantages? From what I
> > gathered:
> >
> > - no need to install bash
> 
> Unless you are in Windows or OS X. OS X has a shell, but not bash.

>From http://support.apple.com/kb/TA27005:

"The default shell (or command-line interface) used in Mac OS X 10.0 through 10.2.8 is tcsh (with 10.3 and 10.4 it's bash). With Mac OS X 10.2 or later, other interactive shells are included, such as bash and zsh."

Stephen
