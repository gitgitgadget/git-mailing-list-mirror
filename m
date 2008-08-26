From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in gittutorial
Date: Tue, 26 Aug 2008 10:45:18 +0200
Message-ID: <4d8e3fd30808260145k56f5d8dcmbbbd6bcaeaa878a6@mail.gmail.com>
References: <20080825215023.11822a20@paolo-desktop>
	 <loom.20080825T200956-169@post.gmane.org>
	 <7v63pog3rn.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808251512x126502bj5f154b58d7ae51a2@mail.gmail.com>
	 <7vy72kbov4.fsf@gitster.siamese.dyndns.org>
	 <4d8e3fd30808260116o543f1a61sd05070fe02f69d2e@mail.gmail.com>
	 <279b37b20808260124q5b1c834cna1afd328766adf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 10:46:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXuC1-0003Ku-1s
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 10:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbYHZIpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 04:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbYHZIpU
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 04:45:20 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:28895 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbYHZIpT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 04:45:19 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2231931wfd.4
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 01:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Kmeh1S9C0NTjmVG6eIBhgDPwvohV1CEnLeNFsjG0OTU=;
        b=Eat4e8Q7+BDoNPQh/Oih5pW0Ms/FVzIicw/V2Smlf/5j+7B8wzzv1JrefP5AdNTLFO
         VTIuOrC5QQfLsBNEw1kRmWH5uthve/2VcQRVjAmvqhCl4vw3YBiwz8IUKRASABCXGvuS
         cpSWSEeJOSh0WWEnejjVWXeJBk8JXdxK2p+8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aoU0zYRYZrRUJNQVJRTbC7VKR2lZNLPH8iw5LX0V4t0f9uH9u9lyQ5zXAR5gEw1MNj
         nX6GsiC/S808N4L0n46e6jMd4QFhfsWmzlkUORDaAM0GMe65WQTYZmtzWg+wCsAujTGD
         PazLT9/ft/lZulZqNtklDgF8fm49WyFyA7lPo=
Received: by 10.143.1.12 with SMTP id d12mr1895623wfi.297.1219740318820;
        Tue, 26 Aug 2008 01:45:18 -0700 (PDT)
Received: by 10.142.148.17 with HTTP; Tue, 26 Aug 2008 01:45:18 -0700 (PDT)
In-Reply-To: <279b37b20808260124q5b1c834cna1afd328766adf1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93727>

On Tue, Aug 26, 2008 at 10:24 AM, Eric Raible <raible@gmail.com> wrote:
> On Tue, Aug 26, 2008 at 1:16 AM, Paolo Ciarrocchi
> <paolo.ciarrocchi@gmail.com> wrote:
>> +If Alice wants to visualize what Bob did since their historie forked
>
> s/historie/histories/

Thanks, fixed.


Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
