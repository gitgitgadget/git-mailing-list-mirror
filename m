From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 4/7] git push: Display warning on unconfigured default 
	push
Date: Mon, 9 Mar 2009 20:25:21 -0400
Message-ID: <76718490903091725j2bed43b0r4adca79e03dba96a@mail.gmail.com>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
	 <1236638151-6465-5-git-send-email-finnag@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 01:27:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgpo4-00083I-Sl
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 01:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbZCJAZZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 20:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbZCJAZY
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 20:25:24 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:64838 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbZCJAZY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 20:25:24 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1914576rvb.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 17:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i1pBRveiy18wRxmKrgeLlFfwHVFo/RUiivcwsHi1PBI=;
        b=HS3LtXZ6ASh5p5bk6GE7lU2jenUZKQJRxvHT+egTSGR09T103EBLrkCO4lMv5BZNb8
         7Z/MsZZJ2gRUBzEqNcC+jE8olyq4oyuaDXNu9OCwbyWi+dGMNyvghd/lHD+dcQCbm3Cw
         9W3urFpo29ngPeLyiytRX9ijz3YrqWnHngb6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Suq5bWWuLxnC+Rqb6sJCgOeCCs448EXW3olB00N6FMQVTy0riL61mR8Xlm3GQDgbrS
         ru+X1xMS+yoTL2dO9lnVtcdlovsf+9mb3W0o0GpFmKMGCgqiuH3RMFrQQAnxAla1yDX4
         M7By+VmW/9yvzt7X3cvD+bmfiq6aMj7GIUZK4=
Received: by 10.140.142.11 with SMTP id p11mr3360142rvd.234.1236644721870; 
	Mon, 09 Mar 2009 17:25:21 -0700 (PDT)
In-Reply-To: <1236638151-6465-5-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112769>

On Mon, Mar 9, 2009 at 6:35 PM, Finn Arne Gangstad <finnag@pvv.org> wro=
te:
> + =C2=A0 =C2=A0 =C2=A0 " =C2=A0'nothing' =C2=A0: Do not push anythig"=
,

s/anythig/anything/

j.
