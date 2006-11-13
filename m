X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Non-ASCII paths and git-cvsserver
Date: Mon, 13 Nov 2006 15:22:46 -0300
Message-ID: <46a038f90611131022l105b5df3ycdf7aa33016b336e@mail.gmail.com>
References: <45530CEE.6030008@b-i-t.de>
	 <7vvelnjd4p.fsf@assigned-by-dhcp.cox.net> <45587A09.3020605@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 13 Nov 2006 18:23:22 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HYyoRNEK1Pw08vm5cs6H0Wvvi2X9NfBhS60eTbS9zK/mmV8JeTQ8lxhWpxzx9El+Yxx7lUPqs6m9PpEyCO8Ds39JydmjIbTe4zkenXzNyYkwnStclmUAtCJodp4nL4dY+XXiqJRM/l2wticDPUuU+lZX7cXHJ3B8oX3YwQtLv/A=
In-Reply-To: <45587A09.3020605@b-i-t.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31308>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjgSX-0006WY-Tl for gcvg-git@gmane.org; Mon, 13 Nov
 2006 19:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755314AbWKMSWt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 13:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755316AbWKMSWt
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 13:22:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:28301 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1755314AbWKMSWs
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 13:22:48 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2242550nfa for
 <git@vger.kernel.org>; Mon, 13 Nov 2006 10:22:47 -0800 (PST)
Received: by 10.49.3.10 with SMTP id f10mr10282269nfi.1163442166119; Mon, 13
 Nov 2006 10:22:46 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Mon, 13 Nov 2006 10:22:46 -0800 (PST)
To: sf <sf@b-i-t.de>
Sender: git-owner@vger.kernel.org

On 11/13/06, sf <sf@b-i-t.de> wrote:
> Martin, are you sure your patch is needed? (see below)

Not 100% sure. I was just making sure we crossed all the Ts and dotted
the Is. I gather you have tried my patch and it didn't make any
difference. What SQLite and Perl versions are you using?

cheers,



