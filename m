From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: advisability of CIFS/SMBFS
Date: Mon, 13 Jul 2009 22:14:05 +0530
Message-ID: <2e24e5b90907130944i41ae0107va016bf44da2d713e@mail.gmail.com>
References: <f46c52560907130327n1fedcd9ch34a2a73a03b9af5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 18:44:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQOdU-00020q-5J
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 18:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbZGMQoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 12:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752732AbZGMQoH
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 12:44:07 -0400
Received: from mail-qy0-f192.google.com ([209.85.221.192]:41669 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbZGMQoH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 12:44:07 -0400
Received: by qyk30 with SMTP id 30so786302qyk.33
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cJHoZA6vLbntDE2kO/I2lXjaK+DqSG0n8JvMcn00m3o=;
        b=nV05EOx2zdci4UG5zXTR57+xU1AWiP87ncMAHaDQFyH9Sl29KChEQqOCVyd6y0JSZ8
         C4YF7AvhRO0lNMgzRrkTs8124adtCWSmCv2WN0Pw6D9Z0olasfH/9HdFqGPy7EuMhte8
         AdBxasCnw/e3Od+SWfeu3h+hyRkbyQx/wT6sI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iJSjqZeOlClbzEuwqPwTjry2ptULSCBDkeze7tHd9XYSXLZbaVosx7Z2wSEG/cbLBw
         OCt1FF5YV45n/8sEKTdG6pCn3Ll7Bkzpr0StcxiXuS9GPWxSiu8/cTR4uQbFgT9IZCo7
         X9ZaUbaAG0MXHJ+xOi8yDEqh8qdgcFA6jPthE=
Received: by 10.231.15.194 with SMTP id l2mr1151288iba.25.1247503445690; Mon, 
	13 Jul 2009 09:44:05 -0700 (PDT)
In-Reply-To: <f46c52560907130327n1fedcd9ch34a2a73a03b9af5c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123198>

On Mon, Jul 13, 2009 at 3:57 PM, Rustom Mody<rustompmody@gmail.com> wrote:
> I see a mention of CIFS/SMBFS on the faq and some mails but no clear
> position on whether its ok or not.

http://permalink.gmane.org/gmane.comp.version-control.git/122670 and
other mails in that thread may help.

Sitaram
