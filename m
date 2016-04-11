From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] rebase -i: add ack action
Date: Mon, 11 Apr 2016 17:36:45 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604111736060.2967@virtualbox>
References: <1460296343-17304-1-git-send-email-mst@redhat.com> <1460296343-17304-2-git-send-email-mst@redhat.com> <alpine.DEB.2.20.1604111239100.2967@virtualbox> <20160411141428-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, bafain@gmail.com, sunshine@sunshineco.com
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 17:37:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apdu6-0001Oc-HB
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 17:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbcDKPhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 11:37:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:50136 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbcDKPhF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 11:37:05 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MSHax-1bCzgB1MCp-00TYNX; Mon, 11 Apr 2016 17:36:48
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160411141428-mutt-send-email-mst@redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:fO8xC55e6BRDCE3XNeXm9iI2uBrVyyudxAprNaSzNA4sQkM9N4g
 EghYjQkJl+UpWbxFuTkH6ahzIwmOZcGoLJLqv/jvewNR63oD6q7vCfmdb47C+8NTj2FK8Pa
 ttoISQMuTYkWRgQx61x8d6XgTzqvm4FXVPkLEoSoiUHIrSi2JsKjlKxhVFbn6tixsEk1Zjf
 fkalkbdBCgKzhP+Q3o6DA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:syGy45uN81M=:hgIzUohms3yLsfDa3rC8MY
 1TZs3BthCpC7TKaWzuOyalE+HR3OblzufbrPY0R+y2T9igJlVVBa2JlA0Ro/nvPqggX1bE5gr
 r3tHj8YfXLVsxmNk6eqSG210KSAr192BWs15tv+WtkK24nnuin71Ce0dCS70/4cTL4x66rwXv
 pIa+HyQyKabziJa66RQXXSIIk9hftAQ14TTeb4DGRmVHJL3Svza/9Uo740qKL/gI+ZOta2/LK
 CtBriQS+mBFMT/u7zT2g05kU3IpAXj2vJS9zDFK43WWEkK9/u3JgQZ8CiLXymkcvNnSpBmF0q
 eSAuiFtvCCY/aNQpGoI6gKi1NCesjGTP0gJcM02XINRr8f+Vkn+W3LMrbk9yNCsv3wBFAezAt
 S8YXMbBddkwbuJi0WYxDdQ9JZCJQguuKmH9X8/4PTJuQyYUxgX/mYu3Bd1khAbAmjgPK3KRdC
 Uho6xlB8liR4J4vXIHdM+NbHVofFQCBk7UdpfqVR6dGYS0nOcQglLg/ZlhHEQYBw8tnypadru
 czf1asT6wt10XARpE5+oHfACMATF1ggJIJh3N4plP8CTwLLNwZhTgGFhuGvcxEkBH3vSQl0tN
 BdIvvXUB43zCCiaIPERjklWhT1Q3D/wsrZBsIumTOsYuYRB51tVBO9l1CHU/Jl8ws4C7iOzt/
 fbFDOVRXhDoBmqaf/4Cg8ktpKjNv/ulBbLKliz5uuMae79BybCCHRyg9DfpWBs+pQKHFy3bJ0
 iC9QzUSx6cONVhCyUjyh98+0VJifTCKTl0PlxdJ4X7p3jxgHUpwg1/5Gsc7HhoBjn0+sr1CE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291216>

Hi Michael,

On Mon, 11 Apr 2016, Michael S. Tsirkin wrote:

> So far I only see examples of adding footers. If that's all we can think
> up, why code in all this genericity?

Because as far as I can see, the only benefitor of your patches would be
you.

Ciao,
Johannes
