From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 00/11] sha1_name: improvements
Date: Wed, 8 May 2013 16:14:02 +0530
Message-ID: <CALkWK0=WRNF_anMFTux0KUr6NUnPKGCKB3RcC-uaSkCu56fhOw@mail.gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s3-vVUB4VnZP4uBMLAbviV+BMTqDcbO_TxkX+5RE6cnSg@mail.gmail.com> <7v1u9igglk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 08 12:44:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua1rc-0001ug-SD
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 12:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab3EHKoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 06:44:44 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:50912 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab3EHKoo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 06:44:44 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so800587bkc.0
        for <git@vger.kernel.org>; Wed, 08 May 2013 03:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=FWqMqML74qYHvE4tx2U1zsOB+ZTNAGLIrmyvKkeH4sM=;
        b=G2FeL9NtT/zqPMpZsRTuHVe0PEH1zTj/0RaX5HxGcQk3NCtCSziu0zUPgs3xbqhc51
         6u/vUgsBQiTbGBRcUi0USKArU85ujm2kaLLN30ls3XWca8Q0rBg/Ym/L/T5s/rI8VZFP
         bsMDZzJ1ZbOJSGkEvMgboKwv7t24v0+XNV1E97oPcR6SHYYHVOGmn0iy5xD+gxTsmL8m
         JwtrLACe8pWdyPuQ+zSDwa1JZVq62FTIoKmSjJrFeTsa5CqUxh+gwf9o6cC7r09g9yDG
         Jy34G7O434PXkgdITMqsjsstdZe2HbYMyirifxiv3pdTtjFLsPwSbyZ+GRj2jDsP6a1y
         rUjg==
X-Received: by 10.205.34.132 with SMTP id ss4mr1637528bkb.125.1368009882824;
 Wed, 08 May 2013 03:44:42 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Wed, 8 May 2013 03:44:02 -0700 (PDT)
In-Reply-To: <7v1u9igglk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223653>

Junio C Hamano wrote:
> Will queue.  Thanks.

Nit: you might want to add my s-o-b on patches 73027d and b018e8 queued in pu.
