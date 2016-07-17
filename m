Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705982018F
	for <e@80x24.org>; Sun, 17 Jul 2016 12:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbcGQMSO (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 08:18:14 -0400
Received: from mout.web.de ([212.227.15.3]:62582 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbcGQMSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 08:18:13 -0400
Received: from [192.168.178.36] ([79.237.59.68]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0M37rD-1b7Ukb1Nh9-00svZO; Sun, 17 Jul 2016 14:18:06
 +0200
Subject: Re: Question: Getting 'git diff' to generate /usr/bin/diff output
To:	Norman Shapiro <norm@dad.org>
References: <201607161912.u6GJCM79069898@shell1.rawbw.com>
Cc:	git@vger.kernel.org
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <578B7779.6090507@web.de>
Date:	Sun, 17 Jul 2016 14:18:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <201607161912.u6GJCM79069898@shell1.rawbw.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:CygfCiukb3KCrzjvX2DHVDHr/s5fJXOlXY+MMw/gShrJ50uVhIr
 e16swOxBC6hWqHGDKtxGsJBSbnfX+i0rUpev/7uMOPHQNctyLo4ZZdiqzzM2qub9EPld5Ng
 j2Ag6YVSJdcFr+drrtFudVxHIody49rEG3k2HGrm4B394tAg+tVaJGLbLjuFMKkChYLOjua
 zSIr64abtYsXCJgX90Zhw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Deb4Ka5eGWg=:rbEe5E0aT33cqo3eXMj3yS
 D1/AvmUZnmXGnWMgJluPmANL3JJDLalX4AaQNLcSdcV/yxYIZiuUHp0i21Pu8J/JD1TOuvUjf
 V9XdikgeVAX8tOcaIUj1hN+sLC1Tp85WBFyj0tU1z1XEcW6bUZ3/qNp1SE0w/FhD4aH3EJ1p+
 Kg9x2f55EQddFHfB7qwApljFNyw0/b0AMj82k/1oo196TeBkYJANs2CKlObjYz5aG4E1gDLt2
 /HbUHsKfT5aYxji6nbgRUP6LSRH+qiWq5VLGAR7KuGCn8yGdHZTCH/E/HQb1u9AH+GqUbYrCo
 N8OYJNxH0WADFJBL5ttYv9ffnDPsUiXlKvV66OHbLWZCou6cCAePxEjIjkrXdP3uXih7XHOpj
 XI0y2ylVIqlrMfg2NosNgp4PKqe2XbRUo9YavRwUt9uyTnihTicX1XDj3M5kYZDuAlgzX4Ipo
 kP9j9nYc2kGWss3BOHnBDQxeb/8XmY51UwN3iGHI2Kyk3B4GcmlUNZnlguf73OUTohf5it8ZQ
 WnudxWzqeaUXp3n2B4b+1aSzLbwapXQqrtkEroVnxZbaTaO65gd/CDx2QTDXYyOSY3QcshfQJ
 5Rdyun1nLgIT5lneSwU3fOj42shxKCE92JFdeQTGSRSQn7C9fMUEyxKBjIXmDHkSVE06gEa4u
 QCOKR86JMJPzO8vJDgsrovOVEqPzAMKdEn9eEBviL2sVFeFDXrzFDVN3jkPKNSqGAdOlq4ZQx
 e51dn9dqVzlz2NBYHICKePturZ2tw325UhNXk3E/73M/mDQ/Ab2TDMNH5xToxfSN1RBEKMh7M
 IiGt1z4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 16.07.2016 um 21:12 schrieb norm@dad.org:
> I am trying to learn how to use git, and am having difficulty using 'git diff'.
>
> I can't deal with its output very well.

The other replies covered how to use the system's own diff instead. 
Just curious: What makes using git diff difficult and its output hard to 
deal with for you?

Thanks,
René

