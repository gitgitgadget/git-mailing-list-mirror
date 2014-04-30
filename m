From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Wed, 30 Apr 2014 17:25:59 -0500
Message-ID: <53617877b41a9_41a872f308ef@nysa.notmuch>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 01 00:36:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfd7K-0005PL-W5
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 00:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759641AbaD3Wgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 18:36:39 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:60745 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758905AbaD3Wgi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 18:36:38 -0400
Received: by mail-yh0-f52.google.com with SMTP id a41so2137580yho.11
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 15:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=UnuZY9OyEJb2/0lKYCg9dE+ro1i6OiKM7md6LeDD2J4=;
        b=Te8njoTmVGmBg6P+hInUj8/0Q4DcGiH+qMsCXTl7E7ERvDqsUVAEGx6bMX+/zQbFnX
         6KaYE2nDvz0SH6kYtgh0x3OHhXrkwwbQQ3riqJWDB4D1Rc+SSd2Tlw16oNQtXXq/YIzk
         K8EttEs1Z1WuUuhU0YxML1z+idLdCBn2W7QLkk51Mmue9+TN8QNh5QdwM9x0qAsOw1tA
         BndRtQaoUUvbFAzuptMCd4znpqB9pSthxMd8WyWHeerIsOl6Rn++3I9SuQODSMxusJn9
         67DD+Z2Tt0CBq7QttTlKMkqEiWwh6VPV+cbB7hcjPmLEuvLmhv2qPyjKoRqsVjUH7HIq
         Z5ww==
X-Received: by 10.236.81.6 with SMTP id l6mr10011890yhe.29.1398897397672;
        Wed, 30 Apr 2014 15:36:37 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id s6sm45352401yhk.22.2014.04.30.15.36.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 15:36:36 -0700 (PDT)
In-Reply-To: <536173F5.7010905@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247800>

Marc Branchaud wrote:
> On 14-04-30 04:14 PM, Felipe Contreras wrote:
> > Marc Branchaud wrote:
> >> All that said, I don't object to any attempts at improving the command
> >> either.  But I also don't see any kind of improvement that would lead
> >> me to start using "git pull" let alone recommending it to new users.
> > 
> > What is wrong when `git pull` merges a fast-forward?
> 
> Nothing.  Everything.  It depends.

It depends on what? I don't see how a fast-forward `git pull` could
possibly have any trouble.

> > The problems with `git pull` come when you can't do a fast-forward merge, right?
> 
> Some of them, maybe most of them.

Name one problem with a fast-forward merge.

-- 
Felipe Contreras
