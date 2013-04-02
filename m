From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Composing git repositories
Date: Wed, 3 Apr 2013 01:03:20 +0530
Message-ID: <CALkWK0nS7OT8XeGqFmotDjbcHj=rCVVs=C4RCu4e=zd-R4Ztbw@mail.gmail.com>
References: <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <20130331225747.GB11704@elie.Belkin> <CALkWK0mgtfYFd+sT=J-hAMLq=HVF-_a-kT_xxE9-ZzfiBiFBQA@mail.gmail.com>
 <20130402175839.GF24698@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:34:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6yW-00024L-Hl
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762165Ab3DBTeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:34:03 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:39174 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762152Ab3DBTeB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:34:01 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so857187ieb.3
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RPVAMbn4HBdFSTRI/fSRwsALtPPdJNjEzuyELJMnpqE=;
        b=YMPnIcU1lpgiOtqaCeKv7n2kqDtMzZywo/hA6tJXQXCyaeMHxuGmoZ0q/s/KvdjjWp
         iYcwp9yu5JAjs/ex5lDuNZSYMIVXLK0fq+2slIP5rB6zUsJGwbV883zPTpOvoi3zkL8v
         Ps8VZutjijz0m8KFO0uO5GAU+rD//uHZ40q4N/WN7KvJMQDGkMap3f/bkOlYjfiXxn7s
         hZXLLV9qt7HMzd0cBvJtWgRtqE2oMdEmoyqryXhoteY4n/TBVrkeuVrmqQ4bAtbNAWe4
         XJjuksuNXSNdOTMj55SgSpf71JgPDAMIPJzwhXWnqEpdh7JE/ciEMDzH5v2sOGuUIJzM
         SRiA==
X-Received: by 10.50.119.102 with SMTP id kt6mr5878569igb.12.1364931240926;
 Tue, 02 Apr 2013 12:34:00 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 2 Apr 2013 12:33:20 -0700 (PDT)
In-Reply-To: <20130402175839.GF24698@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219860>

Jeff King wrote:
> I'm happy to make my dump available to anyone who wants it, but it's
> kind of big (about 1.4G uncompressed).

Thanks.  Can you put it up publicly somewhere (Dropbox comes to mind),
and send me a link?
