From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit-1.2rc1
Date: Sat, 8 Apr 2006 13:07:09 +0200
Message-ID: <e5bfff550604080407g7606d515qec566f83e0e2d7cb@mail.gmail.com>
References: <e5bfff550604080244y40b36292ja5cfecac28e1e749@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 08 13:07:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSBHm-000688-32
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 13:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWDHLHL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 07:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWDHLHL
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 07:07:11 -0400
Received: from wproxy.gmail.com ([64.233.184.225]:18494 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964861AbWDHLHK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Apr 2006 07:07:10 -0400
Received: by wproxy.gmail.com with SMTP id i11so474415wra
        for <git@vger.kernel.org>; Sat, 08 Apr 2006 04:07:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FYI+lEFxO+LtKziiVINsyOY8b7Fw8/XAdFuC6bRGerGYh9mWZNanlie3vr2ntddghckzOt3fv3iLiophg35kAp505BWBiBac/T49EGwE6Pk2hWFHJEayzQaLfTcoz4Th2LM3KGUtuslG5Hie2i5fN+IvOv1EAAnaGCkBe6myOI4=
Received: by 10.65.43.10 with SMTP id v10mr25538qbj;
        Sat, 08 Apr 2006 04:07:09 -0700 (PDT)
Received: by 10.64.131.14 with HTTP; Sat, 8 Apr 2006 04:07:09 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <e5bfff550604080244y40b36292ja5cfecac28e1e749@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18515>

On 4/8/06, Marco Costalba <mcostalba@gmail.com> wrote:
> qgit is a very fast git GUI viewer with a lot of features .
>
> The biggest new feature this time is *code range filtering*
>

Before hitting the warning pop-up about git version compatibility at
qgit launch,please note that a git with --boundary option support
is required.

git-rev-list --boundary has been merged after git-1.3.0.rc1, so better
upgrade git to latest upstream snapshot git-1.3.0rc3

Of course final qgit-1.2 will be out only _after_  released git-1.3.0

    Marco
