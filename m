From: Lars Noschinski <lars@public.noschinski.de>
Subject: Re: Feature suggestion: git-hist
Date: Wed, 30 Jul 2008 18:34:09 +0200
Message-ID: <20080730163408.GA1859@lars.home.noschinski.de>
References: <20080730133859.368bbd92@pc09.procura.nl> <20080730133334.GB31192@lars.home.noschinski.de> <20080730155835.71289eee@pc09.procura.nl> <20080730145534.GD32057@genesis.frugalware.org> <20080730170326.6f4f1772@pc09.procura.nl> <8aa486160807300823w3dfbdff2m4b9821d71779231d@mail.gmail.com> <32541b130807300858r152d7428j404eaefc04f606@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Lars Noschinski <lars-2008-1@usenet.noschinski.de>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 18:35:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOEdu-0000Q1-9n
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 18:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbYG3QeN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2008 12:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbYG3QeN
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 12:34:13 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:60389 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbYG3QeM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 12:34:12 -0400
Received: from [87.78.141.27] (helo=vertikal.home.noschinski.de)
	by smtprelay11.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1KOEcs-0000CR-Ok; Wed, 30 Jul 2008 18:34:10 +0200
Received: from lars by vertikal.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1KOEcr-0000Ul-3v; Wed, 30 Jul 2008 18:34:09 +0200
Content-Disposition: inline
In-Reply-To: <32541b130807300858r152d7428j404eaefc04f606@mail.gmail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90817>

* Avery Pennarun <apenwarr@gmail.com> [08-07-30 18:26]:
>On Wed, Jul 30, 2008 at 11:23 AM, Santi B=E9jar <sbejar@gmail.com> wro=
te:
>> It cannot be described because there is no annotated tag before this
>> commit. Add --always to show the abbreviated commit as fallback.
>
>Or --tags to include non-annotated tags.

=46or the intended use case, --contains; as the OP wants to know the
oldest version, which contains this commit.
