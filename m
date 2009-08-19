From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 08/12] Add MSVC porting files.
Date: Wed, 19 Aug 2009 17:59:42 +0200
Message-ID: <40aa078e0908190859i266fa77dv3f0812c2ed60a42e@mail.gmail.com>
References: <1250697167-5536-1-git-send-email-lznuaa@gmail.com>
	 <1250697167-5536-2-git-send-email-lznuaa@gmail.com>
	 <1250697167-5536-3-git-send-email-lznuaa@gmail.com>
	 <1250697167-5536-4-git-send-email-lznuaa@gmail.com>
	 <1250697167-5536-5-git-send-email-lznuaa@gmail.com>
	 <1250697167-5536-6-git-send-email-lznuaa@gmail.com>
	 <1250697167-5536-7-git-send-email-lznuaa@gmail.com>
	 <1250697167-5536-8-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 18:00:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdnZu-0004uJ-Ft
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbZHSP7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752756AbZHSP7n
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:59:43 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:50178 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbZHSP7m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:59:42 -0400
Received: by qyk34 with SMTP id 34so3361188qyk.33
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nCiGFnzKBFmE20TVy6AZFQ4IolwkJuyKhs4T7us0Gu0=;
        b=lBbLPX3qA/0rIcSrSoqTnn9WcmDNo+oqxCYLC2X9/Mf07IaRddqw8z04sgZBQ60zqQ
         PsglkloFZ7q+9PcAlg7bWAc8ywOUDjdXQb/BtwcNGUQZp8qkkVweankhw6OgQyck4dz3
         cx3eNkKb1MzeyBIbVQg+K0gDJEvg9D6iy6uRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aD0cowL475k/zMxd4vLIJ/gCmC4NepMz2iHkfITzwH4UM2PDYQ81AFzV0PFxun/jw6
         Y8VF8Uze5eEnbS368UV3MV8hIv8rs4vYxAbKKHfNwdTp3SyGxMwmK51FHM66DMUSQyfG
         SQ1bFRS5PPdaKT1Y+pslVE49cOyaweP1oagUg=
Received: by 10.224.121.129 with SMTP id h1mr6640655qar.55.1250697582618; Wed, 
	19 Aug 2009 08:59:42 -0700 (PDT)
In-Reply-To: <1250697167-5536-8-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126563>

On Wed, Aug 19, 2009 at 5:52 PM, Frank Li<lznuaa@gmail.com> wrote:
> +#endif
> \ No newline at end of file

Please add a newline after #endif.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
