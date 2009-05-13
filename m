From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Showing stash state in bash prompt
Date: Wed, 13 May 2009 12:53:37 +0200
Message-ID: <fabb9a1e0905130353u416086b8i5b685e750ec4b5a5@mail.gmail.com>
References: <20090513094448.GC2106@bug.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>
X-From: git-owner@vger.kernel.org Wed May 13 12:54:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4C6F-0004WI-Uf
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 12:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759282AbZEMKx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 06:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759263AbZEMKx6
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 06:53:58 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:62129 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759440AbZEMKx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 06:53:57 -0400
Received: by bwz22 with SMTP id 22so557364bwz.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 03:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PvySzBTzyUGh/9cHdaOOFU95siE3QEwFfuV4DlIvxtw=;
        b=qeN7D321hPg1EhgYJfvEYwHKWKEL5sEN7oBPmjNN7zprqMoXFYnXR4m69okO6QuKwg
         yDL+hXXI+gvZYcriUHbTRqU2ZeZ138DsFo80sKI9VdCGY+TxJQJUOToFgNzXYNxvkOqn
         jXQU8qFqxPv8ztOe++wGb6Qd+y9hJ1l0cZ4nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TNIqNSPRuRdpCYsBkL94kzeDsTL730f+j6cCDMbPZGTg9Fu9h9YijN7eQugLhk+RfH
         Snz1RAgq50/zoyU79qNEeQPHJAU2Y6LIcbmAMZq5iBwd55SL3JNu0kQAOF4fo5UiPcCZ
         29gYWvbEs3G+q3/AuM2dETHyFXOyUSZL5Shjo=
Received: by 10.103.192.2 with SMTP id u2mr591391mup.31.1242212037089; Wed, 13 
	May 2009 03:53:57 -0700 (PDT)
In-Reply-To: <20090513094448.GC2106@bug.science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119032>

Heya,

On Wed, May 13, 2009 at 11:44, Daniel Trstenjak
<Daniel.Trstenjak@science-computing.de> wrote:

Please have a look at Documentation/SubmittingPatches, available
online at [0], main points that you need to address:
1. inline your patch rather than attaching it
2. commit message
3. signed-off-by line

Feel free to ask if you have any questions wrt how to submit your
patch if the document is unclear.

[0] http://repo.or.cz/w/git.git?a=blob;f=Documentation/SubmittingPatches

-- 
Cheers,

Sverre Rabbelier
