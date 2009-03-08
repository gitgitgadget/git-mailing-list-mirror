From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: Git for Windows 1.6.2-preview20090308
Date: Sun, 8 Mar 2009 22:39:49 +0100
Message-ID: <46d6db660903081439j2ee68037td9f9f234c4b56c8c@mail.gmail.com>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de> <46d6db660903081430m35da0d2eoc97377dfec54b1b5@mail.gmail.com> <9d6091530903081436k20591bdbu69cd73ed2f1c98b5@mail.gmail.com>
Reply-To: christian.michon@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org, msysgit@googlegroups.com
To: Janos Laube <janos.dev@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 08 22:41:28 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wf-out-1516.google.com ([209.85.200.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgQkP-0008KK-4F
	for gcvm-msysgit@m.gmane.org; Sun, 08 Mar 2009 22:41:25 +0100
Received: by wf-out-1516.google.com with SMTP id r34so385368wfc.33
        for <gcvm-msysgit@m.gmane.org>; Sun, 08 Mar 2009 14:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=70+Q6ynNn1jurHfMc+1aO/ZA3CYCCaMcYYnPuMYKSx0=;
        b=toCtJx05Q+kZD7PFHXYhPhmM/P8S0Xg6qM/AgODoZBqf/uZeotVpkVvqA96OFdqBwW
         oZLsObKMqfoypHsz826sM7zPNHVDd3tO1LEvBsb05Bf7aQGXY25+3e3icu35+UrcfGgN
         A41gRnbD3XBc2k3aw8w3vtUg+YIp5YQ0tSnBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=ZCW3XTqZSFMMXIrRosFMcpEZoBNY7+zIodxX0C2D8J27oXt7QwoJyxp1qBDF9MIJWE
         lgeewQxUV/CdiFrhepK4kkXYLYSQwa36crwjyqk91S+iCKIvuaxB+uko24ZY7O9Q6Cgb
         iwFkh5DalNQTfclZg2OtgzGuboz3qb6K+W4GE=
Received: by 10.151.47.7 with SMTP id z7mr866835ybj.8.1236548390910;
        Sun, 08 Mar 2009 14:39:50 -0700 (PDT)
Received: by 10.177.37.21 with SMTP id p21gr3890yqj.0;
	Sun, 08 Mar 2009 14:39:50 -0700 (PDT)
X-Sender: christian.michon@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.180.232.9 with SMTP id e9mr129134bkh.2.1236548390295; Sun, 08 Mar 2009 14:39:50 -0700 (PDT)
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.185]) by gmr-mx.google.com with ESMTP id 15si276366fxm.5.2009.03.08.14.39.49; Sun, 08 Mar 2009 14:39:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of christian.michon@gmail.com designates 209.85.134.185 as permitted sender) client-ip=209.85.134.185;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of christian.michon@gmail.com designates 209.85.134.185 as permitted sender) smtp.mail=christian.michon@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mu-out-0910.google.com with SMTP id i10so382733mue.1 for <msysgit@googlegroups.com>; Sun, 08 Mar 2009 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=MCFQNZ4UYubkzZgrzxbOWo6+euSvRZdCHIXAtBBYzFQ=; b=WbbCqZ+edQgbIue5I/6ZIKMxKWJmMECvYSsWF/0oBhm3IVNX7eYumPUm7ZFVhXnRWV sefEzhPt09bAEPuAVA5bgMBXSwIkPsylRKYhDE7mjO7YbaxHZTFo2r0IcxVE1/04tbRQ KiyWecHqjiSSnt4i7HIqggZI3FthFe/EZTrKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=L3hielfJiTB0oiQvczScrbMi7TEfk6a7KqTSHhPn0+IDoYoqD5FRBjs0+fq0hq6UZQ zu/9aHkiCHOttMUo7C0zmtYFTF4GEleOFhkDsRcIsRwbCalAQDCtw5meGGgdLnRWOqUL jZUUy4dWW9eWPR1AurX7QYsOALhZ1oQyQStp4=
Received: by 10.103.213.10 with SMTP id p10mr2290556muq.17.1236548389152; Sun,  08 Mar 2009 14:39:49 -0700 (PDT)
In-Reply-To: <9d6091530903081436k20591bdbu69cd73ed2f1c98b5@mail.gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112649>


On Sun, Mar 8, 2009 at 10:36 PM, Janos Laube <janos.dev@gmail.com> wrote:
>> I'll look at what could be wrong right now.
>
> as vim says, the syntax files in /share/vim/vim72/syntax are missing,
> i.e. not included with the installer package :-)
>

there are a few actually, but somehow it's not working. I need to find
out what happened, as I actually provided a git repo to vim-7.2 (I
also need to update this repo).

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
