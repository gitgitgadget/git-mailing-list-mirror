From: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
Subject: Re: Workflow for templates?
Date: Wed, 07 Nov 2012 17:03:07 +0100
Message-ID: <509A863B.4090805@ira.uka.de>
References: <20121025211522.GA28437@raven.wolf.lan> <3190de06-2eaf-4a39-91aa-9cc34c20fc8e@zcs> <20121031104403.GC28437@raven.wolf.lan> <20121106195045.GD28437@raven.wolf.lan> <871B6C10EBEFE342A772D1159D13208537AA184A@umechphj.easf.csd.disa.mil> <20121106210719.GG28437@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Josef Wolf <jw@raven.inka.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:58:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TW81B-0003Mp-Qo
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 16:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369Ab2KGP6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 10:58:04 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:50266 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751432Ab2KGP6C (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2012 10:58:02 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1TW80q-0008Ab-6b; Wed, 07 Nov 2012 16:58:01 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1TW80p-0003jI-VK; Wed, 07 Nov 2012 16:57:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121025 Thunderbird/16.0.2
In-Reply-To: <20121106210719.GG28437@raven.wolf.lan>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1352303881.240611000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209136>

Am 06.11.2012 22:07, schrieb Josef Wolf:
> On Tue, Nov 06, 2012 at 08:21:25PM +0000, Pyeron, Jason J CTR (US) wrote:
>> Maybe I lost sight of your problem. Can you give a specific example of where "it" does not work?
>
> I guess it's _me_ who's lost. I can't figure how this is supposed to
> work. Maybe you have an example?

Let me ask a different question: What is wrong with cherry-picking 
downstream changes to your upstream branch? Without rebasing it to 
downstream.

That might mean there is a rather useless merge downstream later on, but 
that's the price you pay for not doing the change in a development branch.
