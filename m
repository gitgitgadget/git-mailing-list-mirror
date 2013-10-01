From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Local tag killer
Date: Tue, 01 Oct 2013 08:45:57 -0400
Message-ID: <524AC405.3040209@xiplink.com>
References: <52327E62.2040301@alum.mit.edu> <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com> <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com> <523D3FD2.4090002@alum.mit.edu> <20130924075119.GD7257@sigill.intra.peff.net> <alpine.LFD.2.03.1309251834210.312@syhkavp.arg> <5246C975.1050504@alum.mit.edu> <CALKQrgeJn1J4ntE_2Lr7Et+Oao=vB1FE6nLfaFJOvLHJLzG9tA@mail.gmail.com> <5247ACB9.40208@alum.mit.edu> <52499797.9030100@xiplink.com> <alpine.LFD.2.03.1309301138200.6331@syhkavp.arg> <5249CDF7.4050904@xiplink.com> <alpine.LFD.2.03.1309301527270.6331@syhkavp.arg> <5249E9C8.1070700@xiplink.com> <alpine.LFD.2.03.1309301839080.6331@syhkavp.arg> <524A3BB6.9060808@xiplink.com> <alpine.LFD.2.03.1309302323190.6331@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Oct 01 14:51:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQzQR-0001nN-UU
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 14:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab3JAMvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Oct 2013 08:51:33 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:57152 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab3JAMvb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Oct 2013 08:51:31 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Oct 2013 08:51:31 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp27.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 031DF2A813F;
	Tue,  1 Oct 2013 08:45:59 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp27.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A26FD2A8443;
	Tue,  1 Oct 2013 08:45:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <alpine.LFD.2.03.1309302323190.6331@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235658>

On 13-09-30 11:28 PM, Nicolas Pitre wrote:
>
> But with my proposal, you'd get a message saying that the tag "baz" is
> ambigous, and that you'd have to use either "libfoo/baz" or
> "libbar/baz".

Yes, and that's good.  I agree with your proposal.  Sorry if that wasn't 
clear.

		M.
