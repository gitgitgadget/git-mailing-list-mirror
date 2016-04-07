From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-stash: Don't GPG sign when stashing changes
Date: Thu, 7 Apr 2016 10:19:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604071017510.2967@virtualbox>
References: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com> <loom.20160407T042319-468@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: daurnimator <quae@daurnimator.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 10:19:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ao5AG-00042F-Qz
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 10:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307AbcDGITk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 04:19:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:57699 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754389AbcDGITi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 04:19:38 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MdnN3-1bBVKX3zIb-00Pegm; Thu, 07 Apr 2016 10:19:29
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <loom.20160407T042319-468@post.gmane.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:clgZIiMA0/y24dFFK1a9zMhh5BJiLzsh1jTlnjB5GgWfe7rWeZp
 IrQYJtJoj6c0BFBBgyOl9535LlM9pitbp7IGQAPEgWSXMJ1IJB05a0zydkgDDrPN255J8RY
 s3oFfdDAr0JfpW6I+3BmeD57GYxpmAUrZ/Wz1V2n21NKvzMErlnXdXFbZBIkSvZydACBF08
 dbC7f1BRO9gJswFx+ECXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yjfdT8R9Z18=:njScfR7g2Kg6NM8D6MHvQx
 Pa0BS8Z3tQRosAbwVQKg9fsT4WGqu/Hol/6QCdV4sdSLyTdncuifW29s92NYXOFrRatwN7Gye
 uQKsEcNn2GaFeRK85VWEoENnx78ivq90yze6lqvMPj8TuKjqkJCw46RoYI+xagFtGtDeOFHeM
 WRhJd0ZsTiXESH2lLGSt7dHkuGn0cQlrcyFDhpZkPqvDSOY8EtLcnRYefRrN4uIde88uRBqAu
 +biP8s1kXGExnyiuOLrCoHQV0qtodWdJWTKjQ1fSnXjA0X0GkaE5EIQ28jyLmBEa5TldIfO5O
 Nk+7+3qR88RlU7F6i5+6rrv9z82zi/Z7ddOpP+kCzEBlGkDh8VpYOr+xGdXCHJkkyRYX9k2Q2
 LVUjeYgzipv5NjK53HNWk7Pnplhn9LkkFyCuTvmqzxyNbFxVJWqj1iNRMwIfXqMoPEu4Nu1Bz
 oKOU9gYsJx8GaQnoTaJpMQn7AQyXfw9gTDw0KRh5AkjMe90+lCFsFn0QqXmU5aochK0RtqYDx
 bI0Plw+qpAIu412KwOAlmp2ROsU4wGNYJmSn3fVzUh37RmK2HWRmzpO/rJae+hzHJMdF7R53w
 v3agWThPQWK3SXTRebCgfi2fCZxIeTxKv5qAxbEu05ouivPI4IeaO+rD957uuOAdxrT6RqRsj
 JCFO9MQIsE9VsCETDUzpShTK6bOAPDp4jfYOlXsLQwcKrq+BL/FMtVC61vphH+cinBF5NKnwD
 sSN8YSC/q5+XNCvrqxEc7dP3XPii/keZNI4BP2j3PXFyFaGi8zwCkEAn+ojsW6F9zRi+tohD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290910>

Hi,

you dropped the Cc: list. So most likely Cameron won't get your mail nor
any response to your mail.

On Thu, 7 Apr 2016, daurnimator wrote:

> Cameron Currie <me <at> cameroncurrie.net> writes:
> > This is helpful for folks with commit.gpgsign = true in their .gitconfig.
> 
> > https://github.com/git/git/pull/186
> 
> I too would like this.
> Bumping due to lack of attention.

It lacks a Sign-off, our convention is to continue in lower-case after the
colon in the commit's subject, and I think that it would be good to write
so much as one paragraph in the commit message.

Ciao,
Johannes
