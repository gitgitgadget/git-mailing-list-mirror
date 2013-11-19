From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: Command-line git Vs IDE+plugin?
Date: Tue, 19 Nov 2013 10:55:10 -0600
Message-ID: <871u2cpc0h.fsf@gmail.com>
References: <vpqiovpfxd1.fsf@anie.imag.fr> <201311191336.31000.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 19 17:55:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VioaK-0006nK-Vi
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 17:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab3KSQz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 11:55:29 -0500
Received: from plane.gmane.org ([80.91.229.3]:55007 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845Ab3KSQz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 11:55:28 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VioaD-0006jH-Si
	for git@vger.kernel.org; Tue, 19 Nov 2013 17:55:25 +0100
Received: from cpe-72-179-6-119.austin.res.rr.com ([72.179.6.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 17:55:25 +0100
Received: from keshav.kini by cpe-72-179-6-119.austin.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 17:55:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-72-179-6-119.austin.res.rr.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:ZRT9895vKTB2LSvBSOqkEWb6av4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238030>

Thomas Koch <thomas@koch.ro> writes:
> But also from experience I can tell that without exception everybody whom I 
> teached Git understood it only after being introduced to the basic concepts of 
> Git and how to inspect and operate them on the commandline. Others told me 
> from similar experiences.
>
> Those concepts are:
>
> - hashes
> - content adressable storage
> - blops being referenced by trees being referenced by commits

A great reference I always point people to for exactly those reasons is
Sitaram Chamarty's "git concepts simplified":

    http://gitolite.com/gcs/

-Keshav
