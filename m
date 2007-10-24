From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 24 Oct 2007 23:09:16 +1000
Message-ID: <ee77f5c20710240609p19086fach8767f0d49a1d381@mail.gmail.com>
References: <20071022063222.GS14735@spearce.org>
	 <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 15:09:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkfzH-0002vI-DZ
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 15:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758298AbXJXNJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 09:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757690AbXJXNJS
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 09:09:18 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:13115 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757492AbXJXNJR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 09:09:17 -0400
Received: by rv-out-0910.google.com with SMTP id k20so160111rvb
        for <git@vger.kernel.org>; Wed, 24 Oct 2007 06:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GiRDmxkSKXpPXqjGagXboKrG4ybjO/vFi3nys8RRQxY=;
        b=FdJh6CTw/Idvrpcybdjc3f1tlaZoRy0Auipme81AGtOpqPq+Dez5QPcsM5Ypo/kNm+t8A/GmT5XmcbtnuN1TZoQwpeEoGSdU2i34ytDENZXhe9m+XsZmoKC5QnBNBozAIDNapL8A2ITAuSSWd9RlNXVvS4saCkuJDwtK+OmH4mY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oLO+j0IuevpgHRX+UGvr6Muxy63kEX8XAeOfhKX45JRx2i6yTOADmsTmFp1z4UwBN5tZZ+KE36sgkA87zAJ0P1HvYy6AK/Cg84sHgkh/nFg/DrEsaQJXA1zhcyi5LAm8JzFVY/JFhvGJMKHg7i7pW5s4n7czNsz49hkbo/uaSKw=
Received: by 10.141.90.17 with SMTP id s17mr255723rvl.1193231356936;
        Wed, 24 Oct 2007 06:09:16 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Wed, 24 Oct 2007 06:09:16 -0700 (PDT)
In-Reply-To: <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62215>

On 10/24/07, Junio C Hamano <gitster@pobox.com> wrote:
>
> * ds/gitweb (Mon Oct 22 10:28:03 2007 +1000) 1 commit
>  + gitweb: Provide title attributes for abbreviated author names.

I was hoping you could include my other two related patches on top of
that one, since they clean it up somewhat.


Dave.
