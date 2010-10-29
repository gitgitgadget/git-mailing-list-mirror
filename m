From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: gittogether session notes
Date: Fri, 29 Oct 2010 15:22:03 -0400
Message-ID: <4CCB1EDB.5080207@gmail.com>
References: <20101029180530.GA18997@sigill.intra.peff.net> <4CCB0E67.60605@gmail.com> <20101029182153.GA19160@sigill.intra.peff.net> <AANLkTi=Hr_Bwu7WYi5PBAphzW+NC_qWR6NN=VuBUsZ83@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Tom Preston-Werner <tom@github.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 21:22:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBuWk-000776-FQ
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 21:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab0J2TWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 15:22:08 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61802 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab0J2TWH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 15:22:07 -0400
Received: by gxk23 with SMTP id 23so2217000gxk.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 12:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=o/0+BxtbrjGjt6X6c7jyipH0klRPh6v2hURf/CRdk4I=;
        b=lcpxT4Uej8hcXw1PXYfvgZkv4RxZBOxOOeNQTCpWDtb8xt6ahOd7wEZ7cTFCxtYanV
         GLc6ks6j6os0Z9/V2OFH/IxVq5PfIIXJ9n/ZiHJEFY4BRFwcaGPdYRTlHRib7Uz+E352
         p60RRGjyvvNlGkzg8l7ruTKpzJ7nK10Z8BKrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=GCeIfP9QE1bDddsczINBileyBP2pNZCPdmY4aq30EbcfPACO1kRdjG/YJbyZ6hwppb
         gRnprvSlA842jo+bwfLSrzCiZzlczABqCnlRz791hGt3NZqPs1D5f2BsrpO5X5QdDQco
         xny6MtJFNAF/v/OwdVsl42NbFNhblKXvbsIp4=
Received: by 10.42.177.65 with SMTP id bh1mr189260icb.102.1288380126173;
        Fri, 29 Oct 2010 12:22:06 -0700 (PDT)
Received: from [10.0.1.131] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id p22sm968429vcf.20.2010.10.29.12.22.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 12:22:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
In-Reply-To: <AANLkTi=Hr_Bwu7WYi5PBAphzW+NC_qWR6NN=VuBUsZ83@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160356>

On 10/29/2010 02:33 PM, Tom Preston-Werner wrote:
> On Fri, Oct 29, 2010 at 11:21 AM, Jeff King<peff@peff.net>  wrote:
>> On Fri, Oct 29, 2010 at 02:11:51PM -0400, A Large Angry SCM wrote:
>>> Did the GitHub folks do the their Git scalability presentation? I was
>>> hoping to see notes and/or slides from that.
>>
>> Yeah, Tom talked about it, but there don't seem to be any notes. He did
>> have pretty slides, though. Tom, are your slides available anywhere? If
>> they're not super-secret, do you mind posting a link on the wiki?
>
> I've added a link to the PDF slides on the wiki. For easy reference
> here's the link:
>
> http://dl.dropbox.com/u/61881/GitHub-Infrastructure.pdf

Thanks Tom.

Unfortunately the slides don't stand on their own (they look nice, 
though). Is there a write up that describes what's the slides are showing?
