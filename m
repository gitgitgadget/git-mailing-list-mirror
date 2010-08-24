From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH re-roll] Do not display 'Switched to a new branch' when
 the branch existed
Date: Tue, 24 Aug 2010 21:06:13 +0800
Message-ID: <AANLkTinXKwUwfXuCzghUgiyck=JBoQLrUn=kPRe0X+a5@mail.gmail.com>
References: <AANLkTimaZF1Q6BPB7CN0Wa5-Ov2ejVfPsmL34vps2VqK@mail.gmail.com>
	<AANLkTi=3z9gJdT8LL3NANFyppUjvOVcrszjf5J5zAKPe@mail.gmail.com>
	<20100818091603.GA6263@burratino>
	<AANLkTikHbj4zA6Kj0wUp6uQUY3w6cM_z0=Pes1jLLTky@mail.gmail.com>
	<AANLkTim7DNasVmaBxWBcUGyGBCZq_HXNdq_=4uKRdxE-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 15:06:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OntCo-0003Gf-22
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 15:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366Ab0HXNGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 09:06:16 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53406 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab0HXNGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 09:06:15 -0400
Received: by eyg5 with SMTP id 5so3300828eyg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 06:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=7zmdnpyfZqVVwAg3ENbclLycDzm2mWjkf3fTTLluRUU=;
        b=U87wqK1kXeUAgOAviHwlGSuWqq2/7FTFAdnPxu79i+yaYX5o/k2RTygNTac09RIx4e
         qaAm9ZGZmrPU+LhNMNW1/V0ft9T3gdNKLPv7PdB+sndq8YA51YRKMcJfYN1x4jmVxOod
         Sb1eHVbtEVJkbEMShJu8Q6HYTb0Cp9ONaGNCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xYggUvmnS8v40MBtIV2EbXG27aIIzv63FBFhue/Px2uGvFk+vtA4XEFtmnErFKVOJY
         pk7MCTG1UGC1S7V+8N6NlcNkL4mgLvuESpauVCqFwXAaClyjEf2lWmRPMpsmQTPX96GQ
         SS5sSj8ES4wbFDxfHufVlUpgcmGLkow8/DRZY=
Received: by 10.213.35.6 with SMTP id n6mr5389015ebd.0.1282655173911; Tue, 24
 Aug 2010 06:06:13 -0700 (PDT)
Received: by 10.213.28.201 with HTTP; Tue, 24 Aug 2010 06:06:13 -0700 (PDT)
In-Reply-To: <AANLkTim7DNasVmaBxWBcUGyGBCZq_HXNdq_=4uKRdxE-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154312>

Hi,

On Tue, Aug 24, 2010 at 2:50 PM, Knittl <knittl89@googlemail.com> wrote:
> sorry for the late reply, i hadn't had access to internet for the last
> week and as it turns i sent my response only to tay

just a heads-up - this has already been fixed since 09a0ec5 in master.

-- 
Cheers,
Ray Chuan
