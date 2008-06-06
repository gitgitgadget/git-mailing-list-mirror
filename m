From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Add subcommand "help" to the list of most commonly used subcommands
Date: Fri, 6 Jun 2008 15:11:58 +1000
Message-ID: <ee77f5c20806052211q6aca39t37d423aa978e098a@mail.gmail.com>
References: <alpine.DEB.1.00.0806050747000.21190@racer>
	 <20080605081911.GA5946@mithlond.arda.local>
	 <7viqwn3g3r.fsf@gitster.siamese.dyndns.org>
	 <408F1687-FC42-4E96-B641-088F200CE8D1@ai.rug.nl>
	 <7v63sn1t0j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pieter de Bie" <pdebie@ai.rug.nl>,
	"Teemu Likonen" <tlikonen@iki.fi>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 07:12:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4UFx-0004JM-FN
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 07:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbYFFFMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 01:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbYFFFMA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 01:12:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:12777 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbYFFFMA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 01:12:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so566123fgg.17
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 22:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JjoE5lnt8Ho1RJd9qYwk+qVL9eWX3FswqrGJJBCm83U=;
        b=YkaDfxYy25SVs4jYv2qdfetH7Z0YTvtwF8je0NHJ2hJDLo7YQUzEFvj9vJoWlU7o3S
         TAkC6+Ey/h0kVkiPAJMkNpmfx9mhvdH2A2mI8/i7lWl4UwH3tWHh1Dt8ZDMUeJaLeWdM
         G1VCiUZqev7zZBwiLGka4bzYTLIL7w53L6jmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cHOLMcoJ210/2tjAAD3qtCNY5mMVt5eNRA/3EwQRMJ0VTre1C1FKVitYTUR9cdCqUN
         lBMpPqa2h88kcoGLeZ9PRTVCgpAbU19/REyuGAKCi+Fy1VvrpM/ZL1U2CYra0ta4hQVn
         8JwD9ucMBorhVIZ6pIRJGTWmdZbakq7a7aVGY=
Received: by 10.86.94.11 with SMTP id r11mr3417954fgb.0.1212729118630;
        Thu, 05 Jun 2008 22:11:58 -0700 (PDT)
Received: by 10.86.74.8 with HTTP; Thu, 5 Jun 2008 22:11:58 -0700 (PDT)
In-Reply-To: <7v63sn1t0j.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84022>

On Fri, Jun 6, 2008 at 7:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pieter de Bie <pdebie@ai.rug.nl> writes:
>
>> On 5 jun 2008, at 20:13, Junio C Hamano wrote:
>>
>>> See 'man git' and 'git help' for more information.
>>
>> I'd like to see something more like
>>
>> See 'git help COMMAND' for more information on a specific command
>
> Yeah, I think that is so far the best color of the shed I suggested
> "Perhaps like this".

I think mauve has the most RAM.


Dave.
