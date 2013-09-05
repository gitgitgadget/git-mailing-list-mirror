From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Thu, 05 Sep 2013 11:31:00 +0200
Message-ID: <52284F54.4080405@viscovery.net>
References: <20130904150853.52EC4121B7E@jed-dev-01.labnet> <522827CE.5040303@viscovery.net> <F8C23E99F5C6884EB99E2A1966D743637F3619A6@cph-gen-exch01.napatech.com> <5228476A.2070505@viscovery.net> <F8C23E99F5C6884EB99E2A1966D743637F3619CB@cph-gen-exch01.napatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"hvoigt@hvoigt.net" <hvoigt@hvoigt.net>,
	Pat Thoyts <patthoyts@gmail.com>
To: =?ISO-8859-1?Q?J=F8rgen_Edelbo?= <jed@napatech.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 11:31:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHVuC-0006Tr-Ar
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 11:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763535Ab3IEJbG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 05:31:06 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254]:54223 "EHLO
	theia.linz.viscovery" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763397Ab3IEJbF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 05:31:05 -0400
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A877416613;
	Thu,  5 Sep 2013 11:31:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <F8C23E99F5C6884EB99E2A1966D743637F3619CB@cph-gen-exch01.napatech.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233944>

Am 9/5/2013 11:18, schrieb J=F8rgen Edelbo:
> Forgetting to push something that you have just=20
> completed is very far from what I am used to.

"Forgetting to push" is just one of many reasons why a branch that is n=
ot
equal to HEAD is not yet pushed... The new restriction is just too tigh=
t.

-- Hannes
