From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Tue, 5 Jan 2010 13:56:20 +0200
Message-ID: <20100105115620.GA27121@Knoppix>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
 <7vskal5c11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 12:56:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS81Z-0005VB-Av
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 12:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab0AEL40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 06:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096Ab0AEL40
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 06:56:26 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:41078 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab0AEL4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 06:56:25 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 52799C832C;
	Tue,  5 Jan 2010 13:56:24 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A04D834FD1C; Tue, 05 Jan 2010 13:56:24 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 221EC2BD49;
	Tue,  5 Jan 2010 13:56:21 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vskal5c11.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136184>

On Mon, Jan 04, 2010 at 09:57:46PM -0800, Junio C Hamano wrote:
> 
>  * il/vcs-helper (2009-12-09) 8 commits
>    According to http://thread.gmane.org/gmane.comp.version-control.git/134980
>    this is very close to completion (or did I overlook a reroll after that?)
>    but the final touch is not there yet.

AFAICT, the only nits about that series in that thread were:

- SoB ping-pong
- Not using warning()

And AFAICT both have been fixed in current pu. Or did I overlook some nit?


-Ilari
