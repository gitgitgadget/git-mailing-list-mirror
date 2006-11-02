X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: git_get_projects_list and $projects_list
Date: Thu, 2 Nov 2006 09:43:37 +0530
Message-ID: <cc723f590611012013v1359efb9qdb5888fc458da22@mail.gmail.com>
References: <cc723f590610310347h58cdd69bse6d96b19479a4f6a@mail.gmail.com>
	 <ei7dq4$828$1@sea.gmane.org> <ei7f7o$bgi$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_54717_15496548.1162440817845"
NNTP-Posting-Date: Thu, 2 Nov 2006 04:13:59 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=cpsMgzkuQ1MuIKqm4awkGEoi2oJ6R6RRtdAHt0XMv5t7id9ctwt+2VQJAKx7UEiJqf1NuIHt6Xy0A/qvciRLquZG0mLOcGHKXtV+pUtaurIwZzgvOc7Z+oSCBmHygUbsaF2uHV2l8lISnqlsXOw6k2BUU1g4WJNu5EQ62UDIsUw=
In-Reply-To: <ei7f7o$bgi$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30685>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfTxc-0006TY-5e for gcvg-git@gmane.org; Thu, 02 Nov
 2006 05:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751313AbWKBENk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 23:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbWKBENk
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 23:13:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:47450 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1751313AbWKBENj
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 23:13:39 -0500
Received: by nf-out-0910.google.com with SMTP id c2so1132549nfe for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 20:13:38 -0800 (PST)
Received: by 10.49.90.18 with SMTP id s18mr3823469nfl.1162440817894; Wed, 01
 Nov 2006 20:13:37 -0800 (PST)
Received: by 10.48.212.18 with HTTP; Wed, 1 Nov 2006 20:13:37 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

------=_Part_54717_15496548.1162440817845
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 10/31/06, Jakub Narebski <jnareb@gmail.com> wrote:

>         $dir =~ s!/+$!!;
>

That works. Attaching the diff below

-aneesh

------=_Part_54717_15496548.1162440817845
Content-Type: text/x-patch; name=gitweb.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eu0n8ctr
Content-Disposition: attachment; filename="gitweb.diff"

ZGlmZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIucGVybCBiL2dpdHdlYi9naXR3ZWIucGVybAppbmRl
eCBiZjVmODI5Li40MzQzNDUwIDEwMDc1NQotLS0gYS9naXR3ZWIvZ2l0d2ViLnBlcmwKKysrIGIv
Z2l0d2ViL2dpdHdlYi5wZXJsCkBAIC04OTcsNiArODk3LDggQEAgc3ViIGdpdF9nZXRfcHJvamVj
dHNfbGlzdCB7CiAJaWYgKC1kICRwcm9qZWN0c19saXN0KSB7CiAJCSMgc2VhcmNoIGluIGRpcmVj
dG9yeQogCQlteSAkZGlyID0gJHByb2plY3RzX2xpc3Q7CisJCSMgcmVtb3ZlIHRoZSB0cmFpbGlu
ZyAiLyIKKwkJJGRpciA9fiBzIS8rJCEhOwogCQlteSAkcGZ4bGVuID0gbGVuZ3RoKCIkZGlyIik7
CiAKIAkJRmlsZTo6RmluZDo6ZmluZCh7Cg==
