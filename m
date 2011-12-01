From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 0/4] git-p4: small fixes to branches and labels; tests
Date: Thu, 01 Dec 2011 08:31:35 +0000
Message-ID: <4ED73B67.6080706@diamand.org>
References: <1322643817-13051-1-git-send-email-luke@diamand.org> <loom.20111130T155409-599@post.gmane.org> <4ED6809A.9020703@diamand.org> <20111130225813.GA11544@arf.padd.com> <20111130230007.GA11598@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 09:31:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RW23M-0005Vl-FB
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 09:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab1LAIbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 03:31:31 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56356 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab1LAIbb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 03:31:31 -0500
Received: by bkas6 with SMTP id s6so2107257bka.19
        for <git@vger.kernel.org>; Thu, 01 Dec 2011 00:31:30 -0800 (PST)
Received: by 10.204.149.22 with SMTP id r22mr6075476bkv.104.1322728289947;
        Thu, 01 Dec 2011 00:31:29 -0800 (PST)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id l5sm9748004bkv.9.2011.12.01.00.31.26
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Dec 2011 00:31:27 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111130230007.GA11598@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186166>

On 30/11/11 23:00, Pete Wyckoff wrote:
> P.S.  Since you're respinning anyway to change the label code,
> can you stick the 'branch with shell char' test from t9801 in
> with t9803?  It feels more appropriate there than with the branch
> tests.  And avoids collision with some Vitor code that will get
> added eventually.
>

OK!
