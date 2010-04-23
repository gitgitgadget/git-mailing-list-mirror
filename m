From: Eric Raymond <esr@thyrsus.com>
Subject: Re: Recent documentation patches, and an RFC on terminology
Date: Fri, 23 Apr 2010 18:29:56 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100423222956.GB21224@thyrsus.com>
References: <20100423215448.1EF5B479E92@snark.thyrsus.com>
 <20100423221433.GB29661@atjola.homenet>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 24 00:30:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5RNs-0001tP-Ox
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 00:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab0DWW35 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 18:29:57 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:48010
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab0DWW34 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 18:29:56 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 4008F479E92; Fri, 23 Apr 2010 18:29:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20100423221433.GB29661@atjola.homenet>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145646>

Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
>                   (your other mail didn't make it to me yet, so I
> couldn't quickly look up how you differentiate between the "staging
> area" and the index).

*Groan*...is the Great Galactic Ghoul randomly eating my patch submissi=
ons
again? I'll check the archives...

Basically, I changed the docs to use "staging area" when talking about=20
workflow and "index" only when describing implementation.
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>
