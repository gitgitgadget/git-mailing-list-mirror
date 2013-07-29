From: Daniele Segato <daniele.segato@gmail.com>
Subject: Re: [PATCH] git-tag man: when to use lightweight or annotated tags
Date: Mon, 29 Jul 2013 20:21:39 +0200
Message-ID: <51F6B2B3.2070404@gmail.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com> <51F13A8F.9040400@xiplink.com> <51F23706.5040009@gmail.com> <51F2375E.1080003@gmail.com> <51F28D08.8050507@xiplink.com> <51F2AFBA.4020602@gmail.com> <51F2E673.5020401@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 20:21:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3s4q-0002J0-PO
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 20:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758660Ab3G2SVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 14:21:44 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:34318 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756439Ab3G2SVn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 14:21:43 -0400
Received: by mail-ee0-f50.google.com with SMTP id d51so1672898eek.9
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 11:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZdLgo0ZTSV+vstmDwsLWqy5LRHGV5IDYINahvMs0O7Y=;
        b=lZvCEHk6lnxEqgxzEbiwSYzGBKo6P2E7DUfw0D8lvkCfXQz89UOA5SnCoebRNsFOeU
         4xKmPv4aNS7SbKK8cy5ubkOKEFBODw/c+luxzB0wrYzYTqeO5ze+T869bxpYKJJ6FDk2
         zpnAzqHkQxx0mvACQJ4Z8NgD2Ie9iQ03woCx5eaTsQPhtHm52Vr/ejBm1ZeaMYekcAOH
         wkwmblYnxzAqtBR5EKE5YZQG3ZpCiVFXVTxAqGYAqIwJhYvFRYeoOFKZCoyrWziuucm3
         ZyYFro6ZJC0R/iquaANEmXJ2RxTnziJD60L8eKBUiRoYVTQzfDNc941o49+9Q74hWW9+
         VEYA==
X-Received: by 10.15.65.72 with SMTP id p48mr1880492eex.59.1375122102726;
        Mon, 29 Jul 2013 11:21:42 -0700 (PDT)
Received: from [192.168.1.16] (host253-69-dynamic.4-87-r.retail.telecomitalia.it. [87.4.69.253])
        by mx.google.com with ESMTPSA id cg12sm103827498eeb.7.2013.07.29.11.21.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 11:21:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51F2E673.5020401@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231317>

On 07/26/2013 11:13 PM, Marc Branchaud wrote:
> On 13-07-26 01:19 PM, Daniele Segato wrote:
>>
>> By the way which is your role in the community?
>> Don't want to be rude, I just don't know who I'm talking about :) the
>> documentation maintainer?
>
> I'm just a git user and (very) occasional contributor.
>
> There's not much structure to the git community.  Anyone who wants git to
> change can post a patch (or patch series) to this list.  The patch can touch
> any area of the code, and it's considered good manners to CC whoever last
> touched the part(s) of the code being patched.
>
> The patch is discussed and revised as needed, and eventually the patch
> thread's participants arrive at a consensus as to whether or not the patch
> should become a part of git.  If the patch is accepted the git maintainer
> (Junio C. Hamano) shepherds the patch through git's release process.  See
> this note:
> 	http://git-blame.blogspot.ca/p/a-note-from-maintainer.html
> for more about that and other aspects of the git development community.
>
> 		M.
>

Thanks.
That helps a bit in understanding how I fit into the ml!

Cheers,
Daniele Segato
