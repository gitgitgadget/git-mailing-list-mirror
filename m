From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-format-patch.txt: update hints for sending patches
 with Thunderbird
Date: Sun, 08 May 2011 22:29:21 +0200
Message-ID: <4DC6FD21.6050503@gmail.com>
References: <4DC6DA6A.7010306@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Sun May 08 22:29:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJAbj-0006wt-S3
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 22:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab1EHU3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 16:29:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62107 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab1EHU31 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 16:29:27 -0400
Received: by fxm17 with SMTP id 17so3242674fxm.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=62bwjqtgfLmOhudzr7oeSiN4FiLuqqWhWtj+RBxMKQk=;
        b=aluJO+3jPesN/VQXudkWXsIRnaBfMuzUN4GGgprNTD2kd/pHYPclVm8MmFbx0MHECi
         sG68LABuBgUIBkOKbZfI44t9sF72y79QCep0uvSCJ0XQEFfP2GlnkCm+sHp2zwkSSQ0Q
         vtfVbh0p0KKAevhsE0KbPOM85/MtITSnsAcRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=BO869d1RiKRF7u1k73pAvpha8UqQkRLHF+Bk4QUl8Rnd4JbhseIQce9kZDCREU6Prv
         vmw70QuSG/LIxGfXMLpEeaNwoaMj24r+67NNXMNH27FDNVeTAbjVz00774xEUMS0Wtza
         pds+YB3iT/Xtalb2eSDJSfm9eFZUthw0rQ+sI=
Received: by 10.223.32.142 with SMTP id c14mr2897219fad.59.1304886564870;
        Sun, 08 May 2011 13:29:24 -0700 (PDT)
Received: from [192.168.178.23] (p5DDB0006.dip0.t-ipconnect.de [93.219.0.6])
        by mx.google.com with ESMTPS id g5sm1768371faa.2.2011.05.08.13.29.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 13:29:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4DC6DA6A.7010306@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173178>

On 08.05.2011 20:01, Michael Schubert wrote:

> Using Thunderbird 3.1.10 setting mail.wrap_long_lines to false
> somehow doesn't stop Thunderbird from wrapping.

Just FYI, I'm using the "Toggle Word Wrap" [1] add-on which works great 
for me when sending patches via Thunderbird. Moreover, it allows to 
easily toggle wrapping on a mail-by-mail basis.

[1] https://addons.mozilla.org/en-US/thunderbird/addon/toggle-word-wrap/

-- 
Sebastian Schuberth
