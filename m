From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 1/6] Rename path_list to string_list
Date: Tue, 11 Mar 2008 17:20:30 +0100
Message-ID: <87iqztz0z5.fsf@lysator.liu.se>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <alpine.LSU.1.00.0802290144410.22527@racer.site> <7vprugfrgw.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802290214150.22527@racer.site> <alpine.LSU.1.00.0803011313020.22527@racer.site> <alpine.LSU.1.00.0803011315180.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 17:22:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ7E7-0005CX-IM
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 17:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbYCKQUV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2008 12:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbYCKQUV
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 12:20:21 -0400
Received: from main.gmane.org ([80.91.229.2]:46563 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480AbYCKQUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 12:20:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JZ7D5-0007wS-4x
	for git@vger.kernel.org; Tue, 11 Mar 2008 16:20:15 +0000
Received: from 79.138.179.234.bredband.tre.se ([79.138.179.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 16:20:15 +0000
Received: from davidk by 79.138.179.234.bredband.tre.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 16:20:15 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 79.138.179.234.bredband.tre.se
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:O8JMbA8BlJuVBIE7GBb+/skbZa4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76874>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/Documentation/technical/api-path-list.txt b/Documentatio=
n/technical/api-path-list.txt
> index d077683..8892cf0 100644
> --- a/Documentation/technical/api-path-list.txt
> +++ b/Documentation/technical/api-path-list.txt
> @@ -1,7 +1,7 @@
> -path-list API
> +string-list API
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Looks like you'll want to add two =3D here.

--=20
David K=C3=A5gedal
