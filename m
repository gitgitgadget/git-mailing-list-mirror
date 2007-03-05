From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Begin SubmittingPatches with a check list
Date: Mon, 5 Mar 2007 18:28:21 +0100
Message-ID: <81b0412b0703050928p441f8105m61b75f08958d9bb4@mail.gmail.com>
References: <200703050823.l258NgT9008266@localhost.localdomain>
	 <20070305095101.GA792@diana.vm.bytemark.co.uk>
	 <Pine.LNX.4.63.0703051554240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070305150418.GD3481@diana.vm.bytemark.co.uk>
	 <Pine.LNX.4.63.0703051631350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?Q?Karl_Hasselstr=C3=B6m?=" <kha@treskal.com>,
	"Xavier Maillard" <zedek@gnu.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 18:28:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOGzA-0001zO-FV
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 18:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbXCER22 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 12:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752816AbXCER22
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 12:28:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:31923 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbXCER21 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 12:28:27 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2166874nfa
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 09:28:22 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FpGFeClZvkT3W95jJ5tr3Tw4ImJxOPkJkKuga3kv4pyA0VaXVJ0yJnjUvcbOsR/tHTiOqvdqI0fFTLnJy+ZYhpQF28naaiWkkbi4r3KSww0WfSzY2BIwiGN26oJb9lWwjN9+foYSiSjtpLfBtsIXt6HEG63dY6e72XVozuxDT0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j9JN9WZD971i7GIVI77YP7VRy8mhp0e6DPybJ6rSLNE6Epql79MF1xlHIjfFF9DUh5SlTWMs2OFUOkCgDfp3KnWBkD8bqTsKIdlXGr5TeD9hfo0QPQW9T87VD+yKv7IeuFZ4p1r1dhgz9h8N9r06yTsVqpI0hCbv/tgCv8l+iGg=
Received: by 10.78.164.9 with SMTP id m9mr660274hue.1173115701633;
        Mon, 05 Mar 2007 09:28:21 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Mon, 5 Mar 2007 09:28:21 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0703051631350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41465>

On 3/5/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> +       - do not attach your patch, but paste it in the mail
> +         mail body, unless you cannot teach your mailer to
> +         leave the formatting of the patch alone

"mail" twice in the first and seconf line
