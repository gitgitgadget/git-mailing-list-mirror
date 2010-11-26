From: Bond <jamesbond.2k.g@gmail.com>
Subject: Re: using git with Google Code
Date: Fri, 26 Nov 2010 16:25:08 +0530
Message-ID: <AANLkTi=7_U3yTYHNFZD6Lfwxe77xyD1kS29egLEwAEeB@mail.gmail.com>
References: <AANLkTiksVbmUX9QE6B385UjboqcvgAo+mwKP_X--P+83@mail.gmail.com>
	<20101125150357.GB16049@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 11:55:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLvxW-0003D5-4r
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 11:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab0KZKzL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 05:55:11 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49034 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab0KZKzK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Nov 2010 05:55:10 -0500
Received: by iwn7 with SMTP id 7so560793iwn.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 02:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=USKALzyMxoYZrD4/NHD7rKx0EiUCFJK4FwP2BMCBhtE=;
        b=O+mrAT/QAHqqIG2k0mdBotWazkmgkyy6Vlbc7zsTslgvP58+ioWgE16t6FG9ealUif
         INpxPmi2zk8/Zj9J+56Wrc7B1kHggr6lnp94/pyV/wSdI2EUk8rJyUR9ponEz+knldnt
         GDxb8ceZggKjkTnqS+d9ydNIl23uTjOvTF+Xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uQM9xGRcWEuEHxQk7JAcoAJF9SIFo5EB66dGku8UO0Ufa2PmGPTIt19u4/wIdcg6pa
         gWy1+gqLqIqsOVz4uoHCwDN4yy0/1uyXzGw/Nhv1YHvtBofDnzHzxg7h+7oOrCz2ejFE
         8Da2i5EintLSxt+b832GLprZHRgxTcd+9aIdY=
Received: by 10.42.176.133 with SMTP id be5mr603970icb.487.1290768908278; Fri,
 26 Nov 2010 02:55:08 -0800 (PST)
Received: by 10.42.167.69 with HTTP; Fri, 26 Nov 2010 02:55:08 -0800 (PST)
In-Reply-To: <20101125150357.GB16049@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162209>

On Thu, Nov 25, 2010 at 8:33 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Bond wrote:
>
>> git svn clone --username me =A0https://myproject.googlecode.com/svn/=
trunk
>> git: 'svn' is not a git command. See 'git --help'.
>>
>> Did you mean one of these?
>> =A0 =A0 =A0 fsck
>> =A0 =A0 =A0 show
>
> Is git-svn installed?
>
I do not remember if it was installed or not.After reading your
message I did an apt-get to git-svn I am using Ubuntu 10.04  64 bit.
On my project there is no single file right now.
