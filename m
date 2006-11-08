X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: [RFC] git-gui: A commit / fetch / push interface
Date: Wed, 08 Nov 2006 13:46:09 +0800
Message-ID: <45516F21.9070901@gmail.com>
References: <20061107083603.GB9622@spearce.org> <17745.3287.358673.265578@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 05:47:26 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VY7qUwPugwkD5aSVSvZpZG8YoPw7oLBviKOIFj4ntzLHOC+N/xTPWEtGOyzzcbfu8Kq5oRAeBvlVXnzLIW8lZxhLgYYJ55lvJY23kUs/coGfbJewgR/f7M3+qkZ5H5/6Ga3A3WegN4JHfUWEoxkyGmnOY5xx1rVZu1JYUqwbOvs=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <17745.3287.358673.265578@cargo.ozlabs.ibm.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31119>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhgHP-0004H9-4f for gcvg-git@gmane.org; Wed, 08 Nov
 2006 06:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754325AbWKHFrP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 00:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754326AbWKHFrP
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 00:47:15 -0500
Received: from nz-out-0102.google.com ([64.233.162.203]:41208 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1754324AbWKHFrO
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 00:47:14 -0500
Received: by nz-out-0102.google.com with SMTP id z3so1354634nzf for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 21:47:13 -0800 (PST)
Received: by 10.35.98.6 with SMTP id a6mr10796194pym.1162964833358; Tue, 07
 Nov 2006 21:47:13 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id w43sm7191070pyg.2006.11.07.21.47.11; Tue, 07 Nov 2006 21:47:13 -0800 (PST)
To: Paul Mackerras <paulus@samba.org>
Sender: git-owner@vger.kernel.org

Paul Mackerras wrote:
> Shawn Pearce writes:
> 
>> I liked it and wanted to start making it available to some folks I
>> work with who are more comfortable with the mouse than they are with
>> the keyboard.  At first I tried fixing a few of the outstanding bugs
>> in gitool but I eventually wound up rewriting the thing from scratch.
> 
> Cool!
> 
>> I have posted a repository with the source on pasky's service:
>>
>> 	http://repo.or.cz/w/git-gui.git
> 
> Shouldn't the "w" be "r" there?  It gave me an error "Can't lock ref"
> with the "w".
> 
This it a gitweb URL, not a repos URL for 'git clone', you can only view
it in web browser.
