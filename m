From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>"
 better
Date: Wed, 17 Jun 2015 21:29:42 +0200
Message-ID: <5581CAA6.5080306@web.de>
References: <558127CB.70603@web.de>
 <CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
 <vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org>
 <vpqoaketusa.fsf@anie.imag.fr> <mlrn9r$9ho$1@ger.gmane.org>
 <vpqtwu6sf4r.fsf@anie.imag.fr> <xmqqoake4akt.fsf@gitster.dls.corp.google.com>
 <xmqqd20u48at.fsf@gitster.dls.corp.google.com> <5581A3A3.1070908@web.de>
 <vpqh9q6gsdt.fsf@anie.imag.fr> <xmqqpp4u6swo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	"Andres G. Aragoneses" <knocte@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:30:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5J2N-0000Gg-CV
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbbFQT34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:29:56 -0400
Received: from mout.web.de ([212.227.17.11]:61881 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693AbbFQT3z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:29:55 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Lu4uA-1YxzDC1jgE-011NxX; Wed, 17 Jun 2015 21:29:44
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <xmqqpp4u6swo.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:BxjGnKfYR5G+hoyhWE95EAOpSUojAXLXdNGesJkatExWZ6iWPox
 LJmimVSlzcxiuEXrC0XD6iv+O7TfMsub44nOwxqL416cLZjdra+xTSNjJn8AB1HPxIb30EM
 SvzYXIcInyYx5Y4MgyfC/gLxUS3vTBexYVcRFDWslTUYVTNVtyHoJVvPJBTplF2zL3D54GD
 7qHsE+2BpDuXb1sz8rQ+g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271893>

On 2015-06-17 21.23, Junio C Hamano wrote:
[]
>> Basically, I'm fine with anything starting with "Switch branches or",
>> but please do change the headline ;-).
> 
> Likewise; I agree "switch branches or" part is good.

How about this:

git-checkout - Switch branches or restore changes to the working tree
