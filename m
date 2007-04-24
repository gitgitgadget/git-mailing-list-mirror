From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git todo-list ?
Date: Tue, 24 Apr 2007 12:10:23 +0100
Message-ID: <200704241210.31378.andyparkins@gmail.com>
References: <f36b08ee0704231544r53d1bfbej7ddee0c66d894f3c@mail.gmail.com> <200704240823.00515.andyparkins@gmail.com> <7virbm6ozi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, "Yakov Lerner" <iler.ml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 13:11:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgIvS-00007y-8V
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 13:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbXDXLLL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 07:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbXDXLLK
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 07:11:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:59297 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318AbXDXLLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 07:11:09 -0400
Received: by ug-out-1314.google.com with SMTP id 44so151507uga
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 04:11:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rsNyT6e8Ibi0soBtOeGe1TBw3+14yLuE+/QmEcNzyJkVE5fGtCPPVsakWebPKXCOFnkcUj1zhcoXscKCdTYJLWfK/Dxsrn/qPdhheHGtHdHyUcdVBnZpsA2fhTH3WGKqBoroI2lERytMVJgpeFhogeeLUeGSiiNI7cjp8dXFFuA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Uzef90CzI4zf0IfNLlHHbq6aST1L8k0e8szMSM4K/j+EtPhW3W2m+M7xXkp81tII/k3WMeJFSSZ40p7T8Z43MaMEzBqFC1lJPWMBYwBBjlBXoA2IXzEAQSzjsoQ1eE8ZYNRjDgtJv+92Un0N9eJMK2Erv8DAGQaRObiacvL0Kjg=
Received: by 10.82.155.10 with SMTP id c10mr10611204bue.1177413067970;
        Tue, 24 Apr 2007 04:11:07 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c25sm24310ika.2007.04.24.04.10.49;
        Tue, 24 Apr 2007 04:11:02 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7virbm6ozi.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45442>

On Tuesday 2007 April 24, Junio C Hamano wrote:

> I miss "kernel traffic" and its cousen "git traffic" (which we
> saw only the first issue of, unfortunately).  FWIW, until very
> recently, your "niggles" list $gmane/34244 was still kept in my
> box as 'ticked'.  I recently unticked it as many of the issues
> there have been resolved and some have been made irrelevant.

Wow - I feel useful now :-)  my current "niggles" list is so small that it's 
not worth writing down - is git approaching perfection?

Coincidentally, I was reading through my git-versus-svn post, and found that 
similarly an awful lot of the issues for git had gone away.  I found it 
remarkable that it had happened so fast.

It actually makes it harder for a potential reporter to keep up - git moves 
forward so quickly, that if you blink you've missed five new features going 
in.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
