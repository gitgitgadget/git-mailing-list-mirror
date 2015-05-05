From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Tue, 05 May 2015 07:49:54 +0200
Organization: gmx
Message-ID: <37f399418bbebb3b53a50bf8daffcdc0@www.dscho.org>
References: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
 <20150501175757.GA10569@book.hvoigt.net>
 <CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
 <5547C961.7070909@web.de>
 <CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 07:50:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpVk4-0006OT-LE
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 07:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbbEEFuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 01:50:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:56235 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbbEEFt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 01:49:59 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Ltqmn-1ZHOSs3MyT-0118zM; Tue, 05 May 2015 07:49:55
 +0200
In-Reply-To: <CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:RT5Jq9E2l9uG4XX5knLwIdq2w0h6K+/ukw0yW8Oyr7T+eRGZt2p
 bCZMYQl5KX/bMi/mqBQ+ryDf6riWUpxc2J7xDTMn+lCpxSCkKczHapbCFGQkowkRfacRxhM
 1/gj2Y1abLMWtSLN8mjksH6b49JoWGqD65qZSO7feWKJP3wvdYqaT/UiRmtFIvoBvHfEJBr
 1sXc4lMummm//fknTJ0XA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268385>

Hi Robert,

On 2015-05-04 22:21, Robert Dailey wrote:

> Since I am not a linux user, I have implemented this feature against
> the Git for Windows fork of git. I am not able to verify changes if I
> make them directly against the Git repository.

That is why I worked so hard on support of Vagrant: https://github.com/msysgit/msysgit/wiki/Vagrant -- in short, it makes it dead easy for you to set up a *minimal* Linux VM inside your Git SDK and interact with it via ssh.

With the Vagrant solution, you can easily test Linux Git even on Windows.

Ciao,
Johannes
