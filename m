From: Frans Pop <elendil@planet.nl>
Subject: Re: 'git gc --aggressive' effectively unusable
Date: Sat, 3 Apr 2010 23:16:19 +0200
Message-ID: <201004032316.22483.elendil@planet.nl>
References: <201004030005.35737.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 03 23:16:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyAhl-0000RA-Nr
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 23:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986Ab0DCVQ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Apr 2010 17:16:28 -0400
Received: from Cpsmtpm-eml108.kpnxchange.com ([195.121.3.12]:50278 "EHLO
	CPSMTPM-EML108.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755979Ab0DCVQ1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 3 Apr 2010 17:16:27 -0400
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML108.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Sat, 3 Apr 2010 23:16:25 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <201004030005.35737.elendil@planet.nl>
Content-Disposition: inline
X-OriginalArrivalTime: 03 Apr 2010 21:16:25.0843 (UTC) FILETIME=[EB273C30:01CAD372]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143903>

On Saturday 03 April 2010, Frans Pop wrote:
> Special about this repo is that it contains two huge objects [1], whi=
ch
> could maybe be a factor:
> =A0 =A0 =A0size =A0 =A0pack =A0SHA
> - packages/po/sublevel4/da.po:
> =A0 =A0 =A0495661 =A04654 =A0801cd6451ece536c0ab41f79e09fc52efdf3361f
> - packages/arch/powerpc/quik-installer/debian/po/da.po
> =A0 =A0 =A0149515 =A01403 =A083a787b20817dc4d72db052de4055e7a7c9221d7=
 =A0

To avoid confusion: these sizes are in kB.
