From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor issue: bad Spanish translation
Date: Thu, 11 Jun 2015 08:47:21 -0700
Message-ID: <xmqqsi9yfdrq.fsf@gitster.dls.corp.google.com>
References: <CALBDAwCWbfH-9089Kv=ZJD1wmf076_JCS4G8wzH3BQPhGoWRig@mail.gmail.com>
	<1434035537.29259.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Gabriel <gabrielperren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 17:47:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z34hX-0000U6-62
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 17:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbbFKPr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 11:47:26 -0400
Received: from mail-ie0-f195.google.com ([209.85.223.195]:36431 "EHLO
	mail-ie0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbbFKPrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 11:47:24 -0400
Received: by ierx19 with SMTP id x19so2799913ier.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NRJmZYrZRsHWNq1squSQ/E099IZ8xNfadb0J7FfeV78=;
        b=YiUU7E9s91eI3mVohRFSaReVctVM+tFlBQr+JRkBW08LQXsBVKsRPV/8LrkZdcBi7L
         hr3ymAS4TYvcocqB4Y/o4CXJBfXj6syC/031Zk5qnxgIzsz1G0qcDtQ6/qMFe4p7Yi+P
         9AoRZNuMQKdx9K4eotndix2RANtjcXlpjk2lo42n9ceAJU3dvcAKpbJvF+H4Yd5m/RuS
         mahFWw3A6cmeoTs/D3b0l2fK1cqaa7uMUtmIQRmGRJaBlJ6pxkBorQ1x/YhiPGe6N0LW
         EBFAH+SRnvWn9IQ023apMFxOBBe0RQYEbcxDaC/2AqisTs7uMBpThcW06ePYFF+mfeW8
         AeGw==
X-Received: by 10.107.39.209 with SMTP id n200mr12168121ion.59.1434037643271;
        Thu, 11 Jun 2015 08:47:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id k81sm590716iod.31.2015.06.11.08.47.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 08:47:22 -0700 (PDT)
In-Reply-To: <1434035537.29259.0@smtp.gmail.com> (Gabriel's message of "Thu,
	11 Jun 2015 12:12:17 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271421>

Gabriel <gabrielperren@gmail.com> writes:

> Hi Johannes,
>
> I tried following your instructions but I can locate the sentence
> where the bad translation is. Please see here:
> http://stackoverflow.com/questions/30783818/find-instance-of-string-in-git-core-with-git-grep
>
> Any advice?

Perhaps you are seeing a bad translation in software that is not
ours?  I do not think we have es.po for the Git itself.  gitk has
one but I do not think it gives that message.
