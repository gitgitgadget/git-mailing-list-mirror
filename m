From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 04/25] contrib: remove 'buildsystems'
Date: Fri, 09 May 2014 05:50:04 -0500
Message-ID: <536cb2dc4d308_6b2dde730875@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-5-git-send-email-felipe.contreras@gmail.com>
 <CABPQNSYZ4eWS_9_omZGK5wCD7ap_siEkC10e4ayT8Jp9w1bOSw@mail.gmail.com>
 <536c8e63448c2_25d198d30c55@nysa.notmuch>
 <CABPQNSYgfUdtfT0sYCwGsWQgW3QFOZvSZSyG76dmF6+ZSMaByw@mail.gmail.com>
 <536c966cf0e9c_2bf0e952f079@nysa.notmuch>
 <8761lfnwel.fsf@fencepost.gnu.org>
 <536ca144161a_39ea14ab31097@nysa.notmuch>
 <871tw3nv5a.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: David Kastrup <dak@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 12:50:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiiNe-0008AA-QQ
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 12:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323AbaEIKuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 06:50:12 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:58591 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbaEIKuI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 06:50:08 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so3512318yha.38
        for <git@vger.kernel.org>; Fri, 09 May 2014 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=u+Px8IdizF3S/mnnGwFJ55qFQ1jOvtOzC8iZlfPmNrI=;
        b=H7uOhIuSCuyn+Vdawz/jFf0yc4CGCcLBfoBSp42n2n1yLh4zVTHiLr7NfGB5Ek9QoW
         sB1/Y11KFMDO3emhXS8V9dVRZ58HmToYZf51Yvu3uXmqk290UAFbjEvrB+ldV1TDyf/C
         nweKhjsFJrETzmMLzmUnPYeXObVWbAikJGE+oWi7fj/he1m9qwVlPCjtYEDrpyAMZP9l
         TFZGB1++ezZXDyfEw6p1V7AciojL8SubGxNIk5cNYrkOFJjfbNCSZyJ24kZJK4ZFaEy3
         iH6FA7cuuX0GEa1Pj9Y8dhi2Fe43VeyMBXyhcGAhJafdW0IFB0fsxbl8Vj0WZ1hRSgVp
         UNVQ==
X-Received: by 10.236.132.48 with SMTP id n36mr13650227yhi.149.1399632608047;
        Fri, 09 May 2014 03:50:08 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id n65sm5634160yhc.8.2014.05.09.03.50.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 03:50:07 -0700 (PDT)
In-Reply-To: <871tw3nv5a.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248549>

David Kastrup wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > David Kastrup wrote:
> >
> >> The idea of removing software from distribution is to get rid of
> >> stuff without a user base rather than punishing lazy developers.
> >
> > No.
> 
> So we have you on record that you would want to get rid of stuff
> _with_ a user base

That's what Junio wants.

> and/or to punish lazy developers.

No, that has nothing to do with it.

-- 
Felipe Contreras
