From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 0/2] Re: gitk: can't reload commits with new key binding
Date: Mon, 8 Oct 2012 23:05:55 +0200
Message-ID: <20121008210555.GM951@goldbirke>
References: <7vwqzacdb7.fsf@alter.siamese.dyndns.org>
 <1349190285-7788-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, paulus@samba.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 23:06:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLKWk-00054y-JA
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 23:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163Ab2JHVGC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 17:06:02 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:62699 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab2JHVGB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 17:06:01 -0400
Received: from localhost6.localdomain6 (p5B1308CE.dip0.t-ipconnect.de [91.19.8.206])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MEOzM-1TAOHk0auO-00FREG; Mon, 08 Oct 2012 23:05:56 +0200
Content-Disposition: inline
In-Reply-To: <1349190285-7788-1-git-send-email-andrew.kw.w@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:l0sl/xTXtZA8uBIe+l1zHDOT2FpHoJyeQAxNScBQf6M
 4Il3tnTK4K8PFJPNpC6sPW8bDlesFKt28ggJF15sEgYLTfon6x
 BVAUUaZf38PhtrmLVl6yilkjX9FzXfKmT0DUK0sYLSEMjXiYv4
 et4Vp/oImXcRCog6oYLjA8AaQnk0tZpMHQRuubs2x/S01T4qxg
 wLeVVXzR3pphF+LHxpZTRenxiw7ukvCfF3z1JHr552Ex9d95Dd
 hEszBVf31XkpfCmCPWAMHQdP3d6NdhGO25vQhdV0/KlsBARcbm
 h3eiUsOFck+QolRL/of85HUyUe3wXUdhv5q4IsHqroI4En6tUn
 919uNIYA8hzyg5pdV9dY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207270>

Hi,

(Sorry for the delayed reply, was out of town.)


On Tue, Oct 02, 2012 at 11:04:43AM -0400, Andrew Wong wrote:
> Refactored the code for binding modified function keys as Junio sugge=
sted.
>=20
> Andrew Wong (2):
>   gitk: Refactor code for binding modified function keys
>   gitk: Use bindshiftfunctionkey to bind Shift-F5
>=20

Thanks, this series solves the problem for me.


Best,
G=E1bor
