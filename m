From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 17:27:35 +0200
Message-ID: <4ABCE167.7060204@viscovery.net>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>	 <e5bfff550909250246qed6f2ci4237bdaefd8a18a@mail.gmail.com>	 <4ABC9C5D.5030202@viscovery.net>	 <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com>	 <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com>	 <e5bfff550909250704x724fd4c7lebe7184b4557c7a9@mail.gmail.com>	 <4ABCCFE4.6070202@viscovery.net> <e5bfff550909250718y51709692kc8d1e2586017341b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 17:28:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrCi6-0005h2-DW
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 17:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbZIYP1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 11:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbZIYP1e
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 11:27:34 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39699 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbZIYP1d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 11:27:33 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MrChr-0006G0-VO; Fri, 25 Sep 2009 17:27:36 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B3BC09614; Fri, 25 Sep 2009 17:27:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <e5bfff550909250718y51709692kc8d1e2586017341b@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129092>

Marco Costalba schrieb:
> On Fri, Sep 25, 2009 at 15:12, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Does that work?
>>
> 
> No it doesn't.
> 
> I had already C:\Program Files\Git\cmd in path, probably added by
> msysgit installation.

The point of the exercise is to not use the git.cmd wrapper. I.e. point
your path not into C:\Program Files\Git\cmd, but into the bin directories
so that you run git.exe, not git.cmd.

-- Hannes
