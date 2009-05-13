From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: rebase edit handling
Date: Wed, 13 May 2009 16:59:28 +1000
Message-ID: <fcaeb9bf0905122359s28a2229bwfbc4aa18cad45227@mail.gmail.com>
References: <fcaeb9bf0905122351y3a1235e8s5cc9b83c225ca9c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 13 08:59:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M48RY-0008VW-IH
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 08:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbZEMG7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 02:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbZEMG7s
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 02:59:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:32082 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbZEMG7r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 02:59:47 -0400
Received: by yw-out-2324.google.com with SMTP id 5so254083ywb.1
        for <git@vger.kernel.org>; Tue, 12 May 2009 23:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=XtXfqriMVARGFI+vMFX1DEiFGDDLhkn4Hq27PObQBLg=;
        b=hyBVyzqa8okrO3czIJZaQ2uewQtdB1SOfeDO1lOWzhSDpnybkJOe8oppD+n6ctQxMz
         TQzwOvcrPY01K2Fkry/e2xuTpGUdCqhupZRCl/z8FTq1B8yq0tcxqzg0n2wsiYeObceM
         EdW2zq7M8FSslQ4uLLCnrTNpFOYvPQKK4zyhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=Z5uXpRaiec19p+Oc4vuLIIbpzlhSR/F2QZ0x/oXhVyEpNv26V5MQOY6662Pdm9XfKZ
         4LHe5voxUa3j6JGYuzuqx8922lxNyb6COA/qFZ6M42wb79Zb8RUfhy3yaA5Ji3mNbA/F
         JFbR6hulmh8CpG/gqX0v8IYa4yu9VP0U0n0lE=
Received: by 10.100.138.10 with SMTP id l10mr382174and.61.1242197988146; Tue, 
	12 May 2009 23:59:48 -0700 (PDT)
In-Reply-To: <fcaeb9bf0905122351y3a1235e8s5cc9b83c225ca9c6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118991>

On Wed, May 13, 2009 at 4:51 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Hi,
>
> Could we unit the way to squash/edit commits in rebase? If I squash a

Sorry I meant "unique"
-- 
Duy
