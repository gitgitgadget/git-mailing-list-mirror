From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 2 Feb 2012 03:46:24 -0600
Message-ID: <20120202094624.GF3823@burratino>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 <1328145320-14071-2-git-send-email-felipe.contreras@gmail.com>
 <20120202081622.GB3823@burratino>
 <CAMP44s3FxUmnpQevoV2ARJpWK9CJ16zXDmpJRDOLHNW6RdSc5Q@mail.gmail.com>
 <20120202091059.GE3823@burratino>
 <CAMP44s0nD4p9=fwpLwchmGJ123onLmRaSPmOL+cYpTFCJ-jwXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 10:46:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RstFh-0005es-Gy
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 10:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123Ab2BBJqn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 04:46:43 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56934 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045Ab2BBJql convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 04:46:41 -0500
Received: by iacb35 with SMTP id b35so2902047iac.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 01:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VrB0FDLFNZbsQZmO79O9degHzAH594XyuW9qMFYGF+E=;
        b=l+YqIocJaIM00O+8pWDmXM5L8SxsvH5Rz0M6IQSa4nQCI69SJdWjW/lVsgK2BkJqpN
         qYtt85qYVCsj7Mryqqu16IMukkC8dkkKoDvMBJBGRDCLbtAwSWBjT8pqHnJP3gkJt5gf
         QpiMsMxoS8V6xpAtr+kfpTkzPf/GUrmat3nVY=
Received: by 10.42.131.129 with SMTP id z1mr1768735ics.53.1328176001198;
        Thu, 02 Feb 2012 01:46:41 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ub10sm9238831igb.7.2012.02.02.01.46.40
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 01:46:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s0nD4p9=fwpLwchmGJ123onLmRaSPmOL+cYpTFCJ-jwXw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189610>

=46elipe Contreras wrote:
> On Thu, Feb 2, 2012 at 11:10 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> See [1] for details. =C2=A0If there's no obvious explanation, I'd su=
ggest
>> contacting the postmaster.
>
> But there's nothing like the taboo words in the mail:
> http://vger.kernel.org/majordomo-taboos.txt

Why are you telling me?  I am not the postmaster.  I can't do anything
to investigate it or fix it.
