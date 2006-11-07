X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Tue, 7 Nov 2006 19:13:31 +0100
Message-ID: <81b0412b0611071013j51254a40s749fb6cba65e6873@mail.gmail.com>
References: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com>
	 <45507965.3010806@peralex.com>
	 <81b0412b0611070555u1833cc8ci1d37d45782562df8@mail.gmail.com>
	 <eiq9vm$l7c$1@sea.gmane.org>
	 <81b0412b0611070928l7be83e08kbfc9657937fe7c92@mail.gmail.com>
	 <20061107174859.GB26591@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 18:14:25 +0000 (UTC)
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lCqY4zMd994QuAJ9gFNYQiDCOFF2GgIUOmHU2nJmob+Sce0nGuM82SvUSjtJ9Qqf6Ax/KGrti31Iors1FUXR7sqJ7PYyYEM0aw5GyKAuC3VCvxpXi8YkFaMgFp0Za4PHp4yR9BcqxPREd3vQ5S0PErA6VQqEe4iBieUOpIIF010=
In-Reply-To: <20061107174859.GB26591@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31084>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhVSB-0005SQ-RH for gcvg-git@gmane.org; Tue, 07 Nov
 2006 19:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754236AbWKGSNe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 13:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbWKGSNe
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 13:13:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:36723 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1753739AbWKGSNd
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 13:13:33 -0500
Received: by ug-out-1314.google.com with SMTP id j40so1419212ugd for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 10:13:31 -0800 (PST)
Received: by 10.78.134.12 with SMTP id h12mr8600907hud.1162923211316; Tue, 07
 Nov 2006 10:13:31 -0800 (PST)
Received: by 10.78.128.2 with HTTP; Tue, 7 Nov 2006 10:13:31 -0800 (PST)
To: "Shawn Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

> The patches are on the mailing list archives somewhere around
> Sept. 5th timeframe from me; as I recall we dropped them as they
> didn't apply on top of Junio's 64 bit index changes (which were
> reverted out of next anyway).

I seem to be unable to find them. Does anyone still has the
patches/branch please? Junio, you did sound interested?
