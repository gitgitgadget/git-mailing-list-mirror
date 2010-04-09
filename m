From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: How can I tell if a file is ignored by git?
Date: Fri, 9 Apr 2010 10:20:13 +0530
Message-ID: <w2hf3271551004082150x620aa21az72b7254f57fbc3f5@mail.gmail.com>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jacob Helwig <jacob.helwig@gmail.com>
To: Eric Raymond <esr@snark.thyrsus.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 06:50:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O06BA-0004FW-Jr
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 06:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111Ab0DIEuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 00:50:40 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51161 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab0DIEue (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 00:50:34 -0400
Received: by gyg13 with SMTP id 13so1592722gyg.19
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 21:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=fCTMamX9DzJ+E7Q1e2Tk9TSvKKrASHrv78p0/utDVW4=;
        b=Qq1YDbi14d9sBogRPEpMzc/cI/7hY7ht/i/debBynnhH20UTnWlM4qm70FvPPe2+A8
         1gGdZ0OnfEVrgsc7FJY3TCDhDVmC746tb5OLsPwSKt1FzybHfcF40DfHAu8pxRQSrHnS
         gxLmFMDJpIEDoyjYgE9TNqAw5aQV5Q5wBNU7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XbS7nRW05osaqv10VsUSs33SjleNAj79W+ywIaEpt7lIB8e9HybH7VDOb7QuZdKFPn
         oLvub+lv/PoPgRj5HpoHDc+BK1mq3qn7cdY00vOyi1xUqR8IsoNlWDd5/zzhYaWmSo45
         bbqAoCfzFndzY0zOVU0Smyd4LaxX9sceHVK9Y=
Received: by 10.90.69.14 with HTTP; Thu, 8 Apr 2010 21:50:13 -0700 (PDT)
In-Reply-To: <20100409040434.8602620CBBC@snark.thyrsus.com>
Received: by 10.90.17.23 with SMTP id 23mr443003agq.82.1270788633176; Thu, 08 
	Apr 2010 21:50:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144396>

Hi,

> I'm planning some work on Emacs VC mode.

I personally use Magit [1]. Just thought you might want to look at it.

-- Ram

[1] http://zagadka.vm.bytemark.co.uk/magit/
