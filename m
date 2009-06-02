From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Duplicating a branch
Date: Tue, 2 Jun 2009 16:19:36 +0100
Message-ID: <BAF61FDE71D344FDB9F1415B5E2AFD75@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:19:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBVmK-0002Wk-3y
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 17:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbZFBPTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 11:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753880AbZFBPTl
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 11:19:41 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:43748 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbZFBPTk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 11:19:40 -0400
Received: by fxm12 with SMTP id 12so6589762fxm.37
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=/eKafLjXO7CnMslf+BpJCCo8EZaXSXJ6ZIovAScsjiU=;
        b=SuB6EItBOzHv8Yr2cB4MKEXv/0XPC0FXCIH3zb98qWpXWmm01x6UFIOroYLRxnMNMI
         jzxnJYCjhW/8yzYE6x3jmdpghfvi43/u7QONYgVhuHjDaxBQPQBlFpkUAt5C4uuBXEIV
         fJa5j4nzFWfRz5x8u0NHW4CqqEHn+V5jb7HOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=qG8RXp6w7sspkQTY/dbhRVtZx4oUFxbmBDOnsaHMUPkS8QetXbLYgIEokilX7ba1BW
         ivhVCmw8IJj5KIsxlmYgqaKThR0HFgmhq5BtU9uVEGjkt11gScM/3tMnxbzz6w+2UDbU
         asTAGSljr5ZjvpFXEzgNEll4nhwFrfdtXgGoU=
Received: by 10.86.36.11 with SMTP id j11mr7988994fgj.56.1243955979666;
        Tue, 02 Jun 2009 08:19:39 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 3sm2166010fge.4.2009.06.02.08.19.38
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Jun 2009 08:19:39 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120517>

Hi,

How do I go about duplicating a branch within a repository, so I can make 
test mods ?

Many thanks in advance,

Aaron 
