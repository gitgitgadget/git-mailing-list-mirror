From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 8 Aug 2007 12:41:28 -0400
Message-ID: <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com>
References: <f99cem$4a4$1@sea.gmane.org> <f99nm6$9vi$1@sea.gmane.org>
	 <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org>
	 <20070807145825.GO21692@lavos.net>
	 <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de>
	 <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>
	 <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>
	 <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com>
	 <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Sebastian Schuberth" <sschuberth@gmail.com>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 18:41:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIobI-00032S-Ax
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 18:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbXHHQlb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 12:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbXHHQlb
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 12:41:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:59561 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbXHHQla (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 12:41:30 -0400
Received: by nf-out-0910.google.com with SMTP id g13so58960nfb
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 09:41:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dz4U78QkMGxYQpDNHRKmZtjaRmrq5fUIrcTPWRBr1WspcJtPL89Kw20n78l3c58Nl4p2svkPcNgHCwnGT4N20ATV8V1F48+iS5qqiNg/+xM87DGBQ44DtCr5ZynKyy1oEL/NEjY+tWlevNqcCsRe9vjXgPc3wDe+UIwSDbGPW8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MhyJ1lWiU4r5866Pxi0h2mjFkScK6qq8s7//w29Q+BoEjx8hMgCZhLQM7+Qq+maQS+RG+67HBDwfiWRNMBCy/V9AekNC5KqofJEps7SQvh+oksYNCU4c7N8mkmn8zVLmIRIkkL5nhb31YTobVjps/y2rh3TlblsdJXa3DtH0Q7U=
Received: by 10.82.183.19 with SMTP id g19mr1013228buf.1186591288477;
        Wed, 08 Aug 2007 09:41:28 -0700 (PDT)
Received: by 10.78.190.5 with HTTP; Wed, 8 Aug 2007 09:41:28 -0700 (PDT)
In-Reply-To: <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55331>

On 8/8/07, Steffen Prohaska <prohaska@zib.de> wrote:
>
> The bottom line for me is, git does not yet support Windows in a
> usable way for the organizations that I need to convince.
>
>         Steffen
>

Have you considered jumping in to help on the msys git port Johannes
Schindelin is working? He has very generously offered to do
essentially everything except find bugs, the latter because he does
not actually use Windows so can't, and is clearly putting a great deal
of effort into this. A stable and complete Windows port may be much
closer than you think.

Mark
