From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Improve --patch option documentation in git-add (updated patch)
Date: Tue, 15 Sep 2009 19:35:04 +0900
Message-ID: <20090915193504.6117@nanako3.lavabit.com>
References: <87ocpxb46g.fsf@jondo.cante.net>
	<7vab1hdppb.fsf@alter.siamese.dyndns.org>
	<87tyzp9da4.fsf@jondo.cante.net>
	<7vskf954sr.fsf@alter.siamese.dyndns.org>
	<87ab1gaol2.fsf@jondo.cante.net>
	<7vbplw28js.fsf@alter.siamese.dyndns.org>
	<87y6p08lz5.fsf@jondo.cante.net>
	<7vmy5fy2hz.fsf@alter.siamese.dyndns.org>
	<87ab0zny27.fsf_-_@jondo.cante.net>
	<237967ef0909130648l36b592aft9c50ccff5d03d1b1@mail.gmail.com>
	<87vdjnlywo.fsf@jondo.cante.net>
	<BLU0-SMTP18292B09CCFD873F4A6DF6AEE40@phx.gbl>
	<87fxaolqhd.fsf_-_@jondo.cante.net>
	<20090915155208.6117@nanako3.lavabit.com>
	<87tyz4k4eg.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sean Estabrooks <seanlkml@sympatico.ca>,
	Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Sep 15 12:35:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnVNR-0008E4-2x
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 12:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbZIOKfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 06:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbZIOKfD
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 06:35:03 -0400
Received: from karen.lavabit.com ([72.249.41.33]:54654 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbZIOKfC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 06:35:02 -0400
Received: from h.earth.lavabit.com (h.earth.lavabit.com [192.168.111.17])
	by karen.lavabit.com (Postfix) with ESMTP id 68C3811B8CC;
	Tue, 15 Sep 2009 05:35:05 -0500 (CDT)
Received: from 6103.lavabit.com (199.197.2.145)
	by lavabit.com with ESMTP id HHSWQ4WTVLFG; Tue, 15 Sep 2009 05:35:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=O+iVnzRVgzvzVSfK6Haszx5DiPQ7k4k5GEvuiZRvhOoGs3kYz8fBrbBNs2m5A84glxWk7bWjeyGONQkgOLrNYxUkdG2QsPmssZxQpEBJ0LsdzcVY/MJIcsWKovZjCATBE0wl/LW+WqheHQB4JFQBodnJfl5ps5kWFt/EynUeosM=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <87tyz4k4eg.fsf@jondo.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128525>

Quoting Jari Aalto <jari.aalto@cante.net>

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> Sorry, but this patch doesn't seem to apply anywhere. Have you fetched recently?
>
> Junio merged the patch at 5f2b1e6

Oh, I see.

If so, could you rebase and resend?

It would also be nicer if you followed Documentation/SubmittingPatches when composing your message, writing any additional comments after the three dashes line.

Thank you.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
